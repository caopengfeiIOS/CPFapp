//
//  StatuModel.h
//  LOLBox
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "JSONModel.h"

@interface StatuModel : JSONModel
@property (nonatomic,copy) NSString * img_top;
@property (nonatomic,copy) NSString * title;
@property (nonatomic,copy) NSString * tags;
@property (nonatomic,copy) NSString * say;
@property (nonatomic,copy) NSString * background;
@end
