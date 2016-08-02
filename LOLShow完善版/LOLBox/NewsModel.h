//
//  NewsModel.h
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "JSONModel.h"

@interface NewsModel : JSONModel
@property (nonatomic,copy) NSString <Optional>* article_url;
@property (nonatomic,copy) NSString <Optional>* image_url_big;
@property (nonatomic,copy) NSString <Optional>* image_url_small;
@property (nonatomic,copy) NSString <Optional>* title;
@property (nonatomic,copy) NSString <Optional>* insert_date;
@property (nonatomic,copy) NSString <Optional>* summary;
@property (nonatomic,copy) NSString <Optional>* is_direct;
@property (nonatomic,copy) NSString <Optional>* image_with_btn;


@end
/*
 "article_id" : "13373",
 "article_url" : "http://lol.qq.com/m/act/a20151208qmx/index.htm",
 "channel_desc" : "鏈�鏂�",
 "channel_id" : "<2>:<12>,<2>:<145>,<2>:<145>:<147>,<2>:<73>",
 "image_spec" : "1",
 "image_url_big" : "http://ossweb-img.qq.com/upload/qqtalk/news/201512/112026476687755_480.jpg",
 "image_url_small" : "http://ossweb-img.qq.com/upload/qqtalk/news/201512/112026476687755_282.jpg",
 "image_with_btn" : "False",
 "insert_date" : "2015-12-11 20:26:47",
 "is_act" : "0",
 "is_direct" : "True",
 "is_hot" : "0",
 "is_new" : "0",
 "is_top" : "True",
 "publication_date" : "2015-12-11 20:20:48",
 "score" : "3",
 "summary" : "涓�鍐屽湪鎵嬶紝澶╀笅鎴戞湁锛佽刀绱ф潵鐪嬬湅鍚э紒",
 "targetid" : "1267929169",
 "title" : "2015鍏ㄦ槑鏄熻禌瑙傝禌鎵嬪唽"

*/