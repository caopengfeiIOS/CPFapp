//
//  CPFSelectView.h
//  LOLBox
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPFSelectView : UIView
//外部要告诉我显示几个title
@property (nonatomic,strong) NSArray * titles;

//要告诉外部你点击了第几个title
@property (nonatomic,copy) void(^selectAtIndex)(NSInteger index);


//对外提供一个接口，让外部设置白色坏块的位置
//x表示滑动的比例
-(void)setSlideViewToOffsexX:(CGFloat)x;
@end
