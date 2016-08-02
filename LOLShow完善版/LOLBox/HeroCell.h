//
//  HeroCell.h
//  LOLBox
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeroModel;
@interface HeroCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (nonatomic,strong) HeroModel * model;
@end
