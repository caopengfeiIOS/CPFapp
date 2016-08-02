//
//  FrindViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "FrindViewController.h"
#import "CPFSelectView.h"
#import "HeroTimeViewController.h"
#import "PapleWallViewController.h"
@interface FrindViewController ()<UIScrollViewDelegate>

@end

@implementation FrindViewController
{
    UIScrollView *_scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)loadData{};
-(void)paseData:(id)data{};
- (void)loadDataWithPath:(NSString*)path{};
-(void)addSearchBar{};
-(void)addUI{
    
    NSArray * array = @[@"精美壁纸",@"英雄时刻"];
    CPFSelectView * selectView =[[CPFSelectView alloc]initWithFrame:CGRectMake(KScreen_Size.width/2-80, 20, 160, 30)];
    selectView.tag = 100;
    selectView.titles = array;
    self.navigationItem.titleView =selectView;
    selectView.selectAtIndex = ^(NSInteger index){
        [self switchScrollViewToPage:index];
    };
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-64-49)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*2, _scrollView.frame.size.height);
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.alwaysBounceHorizontal = YES;
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    //2、添加视图到scrollview上
    PapleWallViewController * paple = [[PapleWallViewController alloc]init];
    paple.view.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:paple.view];
    //把这个控制器设置为当前试图控制器的自控器
    [self addChildViewController:paple];
    
    HeroTimeViewController * time = [[HeroTimeViewController alloc]init];
    time.view.frame = CGRectMake(_scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    [_scrollView addSubview:time.view];
    [self addChildViewController:time];

    
    
    
}
-(void)switchScrollViewToPage:(NSInteger)index
{
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentOffset = CGPointMake(index*_scrollView.frame.size.width, 0);
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //1、获取scrollView的偏移
    CGFloat offsexX = scrollView.contentOffset.x;
    CGFloat x = offsexX/scrollView.frame.size.width;
    NSLog(@"15");
    //2、找到上部视图
   CPFSelectView * selectView = (id)[self.navigationItem.titleView viewWithTag:100];
    [selectView setSlideViewToOffsexX:x];
}




@end
