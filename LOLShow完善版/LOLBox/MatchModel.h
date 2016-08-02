//
//  MatchModel.h
//  LOLBox
//
//  Created by qianfeng on 15/12/19.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "JSONModel.h"

@interface MatchModel : JSONModel
@property (nonatomic,copy) NSString * matchresult;
@property (nonatomic,copy) NSString * matchtime;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * refWebUrl;
@property (nonatomic,copy) NSString * state;
@property (nonatomic,copy) NSString * teamalogo;
@property (nonatomic,copy) NSString * teamaname;
@property (nonatomic,copy) NSString * teamblogo;
@property (nonatomic,copy) NSString * teambname;
@end
/*
 matchid" : 9760,
 "matchresult" : "1:3",
 "matchtime" : "2015-11-22 17:10:00",
 "name" : "德玛西亚杯IG VS EDG",
 "refWebUrl" : "",
 "state" : "ended",
 "teamalogo" : "http://ossweb-img.qq.com/upload/qqtalk/lol_live/team_club_6.png",
 "teamaname" : "IG",
 "teamblogo" : "http://ossweb-img.qq.com/upload/qqtalk/lol_live/team_club_13.png",
 "teambname" : "EDG"
*/