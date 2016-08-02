//
//  MatchTableViewCell.m
//  LOLBox
//
//  Created by qianfeng on 15/12/19.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "MatchTableViewCell.h"
#import "MatchModel.h"
#import "UIImageView+WebCache.h"
@implementation MatchTableViewCell
-(void)setModel:(MatchModel *)model
{
    _model = model;
    _stateLabel.text = model.state;
    _timeLabel.text = model.matchtime;
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.teamalogo]];
    _leftImageView.layer.cornerRadius = 22;
    _leftImageView.layer.masksToBounds = YES;
    _leftImageView.layer.borderWidth = 1;
    _leftImageView.layer.borderColor = [UIColor orangeColor].CGColor;
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:model.teamblogo]];
    _rightImageView.layer.cornerRadius = 22;
    _rightImageView.layer.masksToBounds = YES;
    _rightImageView.layer.borderWidth = 1;
    _rightImageView.layer.borderColor = [UIColor orangeColor].CGColor;

    _leftLabel.text = model.teamaname;
    _rightLabel.text = model.teambname;
    if ([model.matchresult isEqualToString:@""]) {
        _midLabel.text = @"0:0";
    }else
    {
    _midLabel.text  = model.matchresult;
    }
    _midLabel.textAlignment = NSTextAlignmentCenter;
    
}
/*
 NSString * matchresult;
 @property (nonatomic,copy) NSString * matchtime;
 @property (nonatomic,copy) NSString * name;
 @property (nonatomic,copy) NSString * refWebUrl;
 @property (nonatomic,copy) NSString * state;
 @property (nonatomic,copy) NSString * teamalogo;
 @property (nonatomic,copy) NSString * teamaname;
 @property (nonatomic,copy) NSString * teamblogo;
 @property (nonatomic,copy) NSString * teambname;
 */

@end
