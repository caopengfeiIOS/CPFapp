//
//  GoodsCollectionViewCell.m
//  LOLBox
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "GoodsCollectionViewCell.h"
#import "GoodsModel.h"
#import "UIImageView+WebCache.h"
@implementation GoodsCollectionViewCell
{
    UIImageView * _photoImageView;
    UILabel * _nameLabel;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20)];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 19, self.frame.size.width, 20)];
    [self.contentView addSubview:_photoImageView];
    [self.contentView addSubview:_nameLabel];
}
-(void)setModel:(GoodsModel *)model
{
    _model = model;
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    _photoImageView.layer.cornerRadius = 20;
    _photoImageView.layer.masksToBounds = YES;
    _nameLabel.text = model.name;
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    
   
}

@end
