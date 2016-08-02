//
//  NewsTableViewCell.h
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;
@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *gameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (nonatomic,strong) NewsModel * model;

@end
