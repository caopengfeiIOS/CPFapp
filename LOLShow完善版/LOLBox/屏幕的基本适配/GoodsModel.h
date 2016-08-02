//
//  GoodsModel.h
//  LOLBox
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "JSONModel.h"

@interface GoodsModel : JSONModel
@property (nonatomic,copy) NSString<Optional> * ID;
@property (nonatomic,copy) NSString<Optional> * icon;
@property (nonatomic,copy) NSString * name;
@end
