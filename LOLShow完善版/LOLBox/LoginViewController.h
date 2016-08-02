//
//  LoginViewController.h
//  LOLBox
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (nonatomic,copy)void(^sendInfo)(NSString * name,NSString* url);
@property (nonatomic,copy) void (^sendMessage)(NSString *headName);
@end
