
//
//  ImageTableViewCell.h
//  LOLBox
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewCell : UITableViewCell<UIScrollViewDelegate>
//外界传递出来的数据，我负责展示
@property (nonatomic,strong) NSArray *imageObjects;
@property (nonatomic,copy) void(^itemSelect)(NSInteger index);
@end
