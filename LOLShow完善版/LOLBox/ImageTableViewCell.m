//
//  ImageTableViewCell.m
//  LOLBox
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
@implementation ImageTableViewCell
{
    NSInteger _index;
    UIScrollView * _scrollView;
    NSTimer * _timer;
    UIPageControl * _pageControl;
    UILabel * _label;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
        [self addTimer];
    }
    return self;
}
-(void)addUI
{
   
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 0, KScreen_Size.width, KImageCell_Height);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate =self;
    [self.contentView addSubview:_scrollView];
    _pageControl = [[UIPageControl alloc]init];
    _pageControl.frame = CGRectMake(_scrollView.bounds.size.width-120, _scrollView.bounds.size.height-24, 120, 24);
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:1];
    _pageControl.pageIndicatorTintColor = [UIColor blackColor];
    [self.contentView addSubview:_pageControl];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _scrollView.bounds.size.height-24, _scrollView.bounds.size.width, 24)];
    _label.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.7];
    _label.textColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    [self.contentView addSubview:_label];
}
-(void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    _timer.fireDate = [NSDate distantFuture];//关闭定时器
}
-(void)timerAction
{
    //首先获取当前是第几页，现在的偏移量
     _index = _scrollView.contentOffset.x/_scrollView.bounds.size.width;
    //翻到下一页，直接指定到下一坐标
    [_scrollView setContentOffset:CGPointMake((_index+1)*_scrollView.bounds.size.width,0) animated:NO];
    
    if (self.imageObjects.count>0) {
        NewsModel * model = self.imageObjects[_index-1];
        _label.text = model.title;
        
    }
   
    _pageControl.currentPage = _index-1;
}
-(void)setImageObjects:(NSArray *)imageObjects
{
    _imageObjects = imageObjects;
    _pageControl.numberOfPages = imageObjects.count;
    _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*(imageObjects.count+2), _scrollView.bounds.size.height);
    for (int i =0; i<imageObjects.count+2; i++) {
        NewsModel * model = nil;
        if (i==0) {
            model = [imageObjects lastObject];
            
        }else if (i ==imageObjects.count+1)
        {
            model = [imageObjects firstObject];
            
        }else
        {
            model = imageObjects[i-1];
            
        }
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(i*_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url_big]];
        
//        _label.text = model.title;
        [_scrollView addSubview:imageView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClicked:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        imageView.tag = 60+i;
//
    }
    //把数据加到视图上
    _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    _pageControl.currentPage = 0;
//    NewsModel * model = imageObjects[_index-1];
//    _label.text = model.title;
    
    [self performSelector:@selector(fireTimer) withObject:nil afterDelay:2];
   
}
-(void)itemClicked:(UITapGestureRecognizer*)tap

{
    NSInteger index = tap.view.tag - 60;
    if (self.itemSelect) {
        self.itemSelect(index);
    }
}
-(void)fireTimer
{
    _timer.fireDate = [NSDate distantPast];//开启定时器
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
//    NewsModel * model = self.imageObjects[index-1];
//    _label.text = model.title;

    //最后一个变为到第一个
    if (self.imageObjects.count>0) {
        if (index == self.imageObjects.count+1) {
            [_scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width, 0) animated:NO];
            //setContentOffset;方法的功能是跳转到你指定内容的坐标
            
            
        }else if (index ==0)
        {
            //第一个变为最后一个
            [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width*self.imageObjects.count, 0) animated:NO];
        }
        
    }
}



@end
