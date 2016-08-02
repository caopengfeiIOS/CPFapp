//
//  ClubCell.h
//  LOLBox
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClubCell : UITableViewCell<UIScrollViewDelegate>
@property (nonatomic,strong) NSArray * imagesArray;
@property (nonatomic,copy) void (^sendInfo)(NSInteger index);
@end
