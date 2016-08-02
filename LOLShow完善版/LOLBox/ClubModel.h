//
//  ClubModel.h
//  LOLBox
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "JSONModel.h"

@interface ClubModel : JSONModel
@property (nonatomic,copy) NSString<Optional> * ID;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * iconUrl;
@property (nonatomic,copy) NSString * fansCount;
@end
