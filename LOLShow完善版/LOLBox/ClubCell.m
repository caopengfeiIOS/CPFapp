//
//  ClubCell.m
//  LOLBox
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "ClubCell.h"
#import "ClubModel.h"
#import "UIButton+WebCache.h"

@implementation ClubCell
{
    UIScrollView * _scrollView;
    UIImageView * _bigImageView;
    
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
-(void)addUI
{
   self.contentView.backgroundColor = [UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:0.7];
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 0, KScreen_Size.width, KClubCell_Height-25);
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width*2, _scrollView.frame.size.height);
    _scrollView.pagingEnabled = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.delegate =self;
    [self.contentView addSubview:_scrollView ];
    UILabel * label =[[UILabel alloc]init];
    CGFloat Width = 90;
    CGFloat height = 25;
    label.frame = CGRectMake((KScreen_Size.width-Width)/2, _scrollView.frame.size.height, Width, height);
    label.text = @"粉丝俱乐部";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:1];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    
    
}
-(void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray = imagesArray;
    for (int i=0; i<imagesArray.count; i++) {
        float Gap = 10;
        float Width = (KScreen_Size.width-6*Gap)/6;
        UIButton * button =[[UIButton alloc]initWithFrame:CGRectMake(Gap+(Gap+Width)*i, Gap, Width, 80)];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(Gap+(Gap+Width)*i, Gap*2+80, Width, 20)];
        ClubModel * model = imagesArray[i];
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.iconUrl] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 66+i;
        label.text = model.name;
        label.textAlignment = NSTextAlignmentCenter;
        button.layer.cornerRadius = 28;
        button.layer.masksToBounds = YES;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor orangeColor].CGColor;
        [_scrollView addSubview:button];
        [_scrollView addSubview:label];
    }
}
-(void)buttonClicked:(UIButton*)button
{
    NSInteger index = button.tag-66;
    if (self.sendInfo) {
        self.sendInfo(index);
    }
}

@end
