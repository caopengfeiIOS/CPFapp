//
//  ClubSearchController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/19.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "ClubSearchController.h"
#import "MatchModel.h"
#import "MatchTableViewCell.h"
@interface ClubSearchController ()
@property (nonatomic,strong) NSMutableArray * headArray;
@end

@implementation ClubSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.lurl);
    
}

-(void)addSearchBar
{
    
}
-(void)loadData
{
    [self loadDataWithPath:[NSString stringWithFormat:ClubSearchUrl,self.lurl]];
    
}
-(void)paseData:(id)data
{
    NSArray * array = data[@"matchlist"];
    [self.dataSource addObjectsFromArray:[MatchModel arrayOfModelsFromDictionaries:array]];
    [self.tableView reloadData];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MatchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ecell"];
    if (cell==nil) {
        cell =[[NSBundle mainBundle]loadNibNamed:@"MatchTableViewCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    MatchModel * model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 114;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
