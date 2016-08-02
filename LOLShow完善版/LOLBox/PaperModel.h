//
//  PaperModel.h
//  LOLBox
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "JSONModel.h"

@interface PaperModel : JSONModel
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * author;
@property (nonatomic,copy) NSString * thumbUrl;
@property (nonatomic,copy) NSString * url;
@property (nonatomic,copy) NSString * thumb_height;
@property (nonatomic,copy) NSString <Optional> * nub;
@end
