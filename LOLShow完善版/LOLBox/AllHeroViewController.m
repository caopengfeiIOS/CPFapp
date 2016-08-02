//
//  AllHeroViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "AllHeroViewController.h"
#import "HeroModel.h"
#import "HeroCell.h"
#import "StatusViewController.h"
@interface AllHeroViewController ()

@end

@implementation AllHeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)loadData
{
    [self loadDataWithPath:AllHero];
}
-(void)paseData:(id)data
{
    NSArray * array = data[@"result"];
    NSArray * models = [HeroModel arrayOfModelsFromDictionaries:array];
    for (int i=0; i<models.count; i++) {
        HeroModel * model = models[i];
        NSDictionary * dict = array[i];
        model.ID = dict[@"id"];
    }
    if (self.dataSource.count>0) {
        [self.dataSource removeAllObjects];
    }
        [self.dataSource addObjectsFromArray:models];
    
    [self.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HeroCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"HeroCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    }
    HeroModel * model = self.dataSource[indexPath.row];
    cell.model = model;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusViewController * statu =[[StatusViewController alloc]init];
    HeroModel * model = self.dataSource[indexPath.row];
    
    statu.link = model.ID;
    [self.navigationController pushViewController:statu animated:YES];
    
    
}

@end
