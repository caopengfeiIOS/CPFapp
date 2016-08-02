//
//  HeroModel.h
//  LOLBox
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "JSONModel.h"

@interface HeroModel : JSONModel
@property (nonatomic,copy) NSString<Optional> *img;
@property (nonatomic,copy) NSString<Optional> *ID;
@property (nonatomic,copy) NSString<Optional> *name_c;
@property (nonatomic,copy) NSString<Optional> *tags;
@property (nonatomic,copy) NSString<Optional> *title;
@end
/*  "id" : "2",
"img" : "http://img.lolbox.duowan.com/champions/Quinn.jpg",
"name_c" : "奎因",
"tags" : "后期,远程",
"title" : "德玛西亚之翼"
*/