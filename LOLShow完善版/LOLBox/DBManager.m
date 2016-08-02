//
//  DBManager.m
//  LOLBox
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "PaperModel.h"
@implementation DBManager
{
    FMDatabase * _db;//数据库对象
}
+(id)defaultDBManager
{
    static DBManager * manager =nil;
    if (manager==nil) {
        manager = [[DBManager alloc]init];
    }
    return manager;
}
-(id)init
{
    if (self=[super init]) {
        [self prepareDB];
    }
    return self;
}
-(void)prepareDB
{
    NSString * dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/DBM"];
    if (_db==nil) {
        _db = [FMDatabase databaseWithPath:dbPath];
    }
    [_db open];
    [self createTableList];
}
//name;
// author;
// thumbUrl;
// url;
// thumb_height;
-(void)createTableList
{
    NSString * sql = @"create table if not exists APP (ID integer primary key autoincrement,name varchar(100),author varchar(100),thumbUrl varchar(100),url text,nub varchar(100));";
    BOOL success = [_db executeUpdate:sql];
    if (success == YES) {
        NSLog(@"表单创建成功");
        
    }
}
-(void)saveAppDetailModel:(PaperModel *)model
{
    NSString * sql = @"insert into APP(name,author,thumbUrl,url,nub) values (?,?,?,?,?);";
    BOOL success = [_db executeUpdate:sql,model.name,model.author,model.thumbUrl,model.url,model.nub];
    if (success == YES) {
        NSLog(@"保存app信息成功");
        
    }
}
-(void)updateModel:(PaperModel *)model
{
//    NSString * updateSql = [NSString stringWithFormat:@"update ()set()"]
    NSString * sql = @"update APP set nub = 1 where name=?;";
    BOOL success = [_db executeUpdate:sql,model.nub,model.name];
    if (success==YES) {
        NSLog(@"更新数据成功");
    }
}
-(void)deleteAppDetailModel:(PaperModel *)model
{
    NSString * sql = @"delete from APP where name=?;";
    BOOL success = [_db executeUpdate:sql,model.name];
    if (success == YES) {
        NSLog(@"删除app信息成功");
    }
}
-(NSArray*)allAppDetailModel
{
    NSMutableArray *array =[[NSMutableArray alloc]init];
    NSString * sql = @"select * from APP;";
    FMResultSet * set = [_db executeQuery:sql];
    while (set.next) {
        NSString * name = [set stringForColumn:@"name"];
        NSString * author = [set stringForColumn:@"author"];
        NSString * thumbUrl = [set stringForColumn:@"thumbUrl"];
        NSString * url = [set stringForColumn:@"url"];
        NSString * nub = [set stringForColumn:@"nub"];
        PaperModel * model = [[PaperModel alloc]init];
        model.name = name;
        model.author = author;
        model.thumbUrl = thumbUrl;
        model.url = url;
        model.nub = nub;
        [array addObject:model];
    }
    return array;
    
}
-(void)deleteTable
{
    NSString * sql = @"drop table APP;";
    BOOL success = [_db executeUpdate:sql];
    if (success == YES) {
        NSLog(@"表单删除成功");
        
    }

}
@end
