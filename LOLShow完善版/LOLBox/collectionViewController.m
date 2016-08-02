//
//  collectionViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "collectionViewController.h"
#import "DBManager.h"
#import "PaperModel.h"
#import "CollectionCell.h"

@interface collectionViewController ()

@end

@implementation collectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
-(void)addSearchBar{};
-(void)loadData
{
    DBManager * manager = [DBManager defaultDBManager];
    [self.dataSource addObjectsFromArray:[manager allAppDetailModel]];
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[CollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    PaperModel * model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBManager *manger = [DBManager defaultDBManager];
    
    PaperModel *model = self.dataSource[indexPath.row];
  
    
    [manger updateModel:model];
    NSLog(@"%@",model.nub);
    [manger deleteAppDetailModel:model];
//    [self.dataSource removeAllObjects];
    [self.dataSource removeObjectAtIndex:indexPath.row];
   
    [manger deleteTable];
    [self loadData];
     [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}



@end
