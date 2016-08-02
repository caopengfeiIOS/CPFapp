//
//  CollectionCell.m
//  LOLBox
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "CollectionCell.h"
#import "PaperModel.h"
#import "UIImageView+WebCache.h"
@implementation CollectionCell
{
    UIImageView * _bigImageView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addUI];
    }
    return self;
}
-(void)addUI
{
    _bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, KScreen_Size.width-80,180)];
    [self.contentView addSubview:_bigImageView];
}
-(void)setModel:(PaperModel *)model
{
    _model = model;
    [_bigImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbUrl]];
}


@end
