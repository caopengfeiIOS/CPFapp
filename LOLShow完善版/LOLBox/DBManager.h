//
//  DBManager.h
//  LOLBox
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PaperModel;
@interface DBManager : NSObject
+(id)defaultDBManager;
-(void)saveAppDetailModel:(PaperModel*)model;
-(NSArray*)allAppDetailModel;
//删
-(void)deleteAppDetailModel:(PaperModel*)model;
-(void)updateModel:(PaperModel*)model;
-(void)deleteTable;
@end
