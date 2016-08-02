//
//  SearchViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "SearchViewController.h"
#import "ClubModel.h"
#import "ClubCell.h"
#import "GuanFangViewController.h"
#import "HeroSearchViewController.h"
#import "HeroViewController.h"
#import "GoodsViewController.h"
#import "ClubSearchController.h"
#import "ScanViewController.h"
@interface SearchViewController ()
@property (nonatomic,strong) NSMutableArray * headArray;
@property (nonatomic,strong) NSMutableArray * otherArray;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       [self creatButton];
   [self loadOther];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
-(NSMutableArray*)headArray
{
    if (_headArray==nil) {
        _headArray = [[NSMutableArray alloc]init];
    }
    return _headArray;
}
-(NSMutableArray*)otherArray
{
    if (_otherArray==nil) {
        _otherArray = [[NSMutableArray alloc]init];
    }
    return _otherArray;
}
-(void)loadOther
{
    if (self.otherArray.count>0) {
        [self.otherArray removeAllObjects];
    }
    [self.otherArray addObjectsFromArray:@[@{@"name":@"英雄资料",@"image":@"default_region_icon_gold@2x"},@{@"name":@"物品资料",@"image":@"friend_header_down_golden@2x "},@{@"name":@"召唤师查询",@"image":@"nav_touch_with_me_info_normal@2x"},@{@"name":@"官方论坛",@"image":@"share_normal@2x"}]];
    [self.tableView reloadData];
    // default_region_icon_gold@2x friend_header_down_golden@2x nav_touch_with_me_info_normal@2x share_normal@2x
}
-(void)creatButton
{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [button setImage:[UIImage imageNamed:@"nav_news_topic_write_topic_normal@2x"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"nav_news_topic_write_topic_press@2x"] forState:UIControlStateSelected];
    [button setTitle:@"扫一扫" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}
-(void)buttonClicked:(UIButton*)button
{
    ScanViewController * scan = [[ScanViewController alloc]init];
    [self.navigationController pushViewController:scan animated:NO];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    return self.otherArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     UITableViewCell * cell = nil;
    switch (indexPath.section) {
        case 0:
            cell = [self tableView:tableView clubCellForRowAtIndexPath:indexPath];
            break;
        case 1:
            cell = [self tableView:tableView otherCellForRowAtIndexPath:indexPath];
            break;
            
        default:
            break;
    }
    return cell;
   }
-(UITableViewCell*)tableView:(UITableView *)tableView clubCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClubCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[ClubCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imagesArray = self.headArray;
    cell.sendInfo = ^(NSInteger index)
    {
        [self pushOther:index];
    };
    return cell;
}
-(void)pushOther:(NSInteger)index
{
    ClubModel * model = self.headArray[index];
    ClubSearchController * search = [[ClubSearchController alloc]init];
    search.title = model.name;
    search.lurl = model.ID;
    [self.navigationController pushViewController:search animated:NO];
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView otherCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bcell"];
    if (cell==nil) {
        cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bcell"];
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    NSString * str = self.otherArray[indexPath.row][@"image"];
//    UIImage *image = [UIImage imageNamed:str];
//    cell.imageView.image = image;
    cell.textLabel.text = self.otherArray[indexPath.row][@"name"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return KClubCell_Height;
    }
    return 50;
}

-(void)loadData
{
    [self loadDataWithPath:SearchDataUrl];
}
-(void)paseData:(id)data
{
    NSArray *array = data[@"clubs"];
     NSArray * models = [ClubModel arrayOfModelsFromDictionaries:array];
    for (int i=0; i<models.count; i++) {
        ClubModel * model = models[i];
        NSDictionary * dict = array[i];
        model.ID = dict[@"id"];
    }
    [self.headArray addObjectsFromArray:models];
    [self.tableView reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section!=0) {
        NSInteger index = indexPath.row;
        switch (index) {
            case 0:
                
                [self goFirst];
                break;
            case 1:
                [self goNext];
                break;
            case 2:
                [self goSecond];
                break;
            case 3:
                [self goThird];
                break;
                
            default:
                break;
        }
    }
}
-(void)goFirst
{
    HeroViewController * hero = [[HeroViewController alloc]init];
    hero.title = @"英雄资料";
    [self.navigationController pushViewController:hero animated:NO];
}
-(void)goNext
{
    GoodsViewController *goods = [[GoodsViewController alloc]init];
    goods.title = @"英雄联盟资讯";
    [self.navigationController pushViewController:goods animated:NO];
}
-(void)goSecond
{
    HeroSearchViewController * search = [[HeroSearchViewController alloc]init];
    search.title = @"召唤师查询";
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:NO];
}
-(void)goThird
{
    GuanFangViewController * guan = [[GuanFangViewController alloc]init];
    guan.title = @"官方论坛";
    [self.navigationController pushViewController:guan animated:NO];
}
//- (void)loadDataWithPath:(NSString*)path{};
-(void)addSearchBar{};



@end
