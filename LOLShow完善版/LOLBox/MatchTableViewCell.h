//
//  MatchTableViewCell.h
//  LOLBox
//
//  Created by qianfeng on 15/12/19.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MatchModel;
@interface MatchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *midLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (nonatomic,strong) MatchModel * model;
@end
