//
//  PaperCollectionViewCell.m
//  LOLBox
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "PaperCollectionViewCell.h"
#import "PaperModel.h"
#import "UIImageView+WebCache.h"
@implementation PaperCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _picImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_picImageView];
        
        
        
    }
    return self;
}
-(void)buttonClicked:(UITapGestureRecognizer*)tap
{
    if (self.sendMessage) {
        self.sendMessage();
    }
}
-(void)setModel:(PaperModel *)model
{
    _model = model;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbUrl]];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClicked:)];
    _picImageView.userInteractionEnabled = YES;
    [_picImageView addGestureRecognizer:tap];

}
-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    _picImageView.frame = CGRectMake(0, 0, layoutAttributes.frame.size.width, layoutAttributes.frame.size.height);
   
    
}


@end
