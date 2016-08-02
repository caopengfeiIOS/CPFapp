//
//  NewsViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "NewsViewController.h"
#import "SCNavTabBar.h"
#import "NewsModel.h"
#import "ImageTableViewCell.h"
#import "NewsTableViewCell.h"
#import "NewsWebViewController.h"
#import "MJRefresh.h"
@interface NewsViewController ()
@property (nonatomic,strong) NSMutableArray * headArray;

@end

@implementation NewsViewController{
    NSString *_path;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self startViewController];
    [self loadHeadData];
    
   
    
    
     
}
-(void)setNavigationBar
{
    [super setNavigationBar];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
}
-(void)startViewController
{
    __weak NewsViewController * new = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        
        [new loadData];
    }];
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        
        [new loadDataWithHead];
    }];
    
    
}
-(void)loadDataWithHead
{
    [MMProgressHUD setPresentationStyle: MMProgressHUDPresentationStyleBalloon];
    //    设置显示的内容
    [MMProgressHUD showDeterminateProgressWithTitle:@"下载中" status:@"loading"];
    
    [self performSelector:@selector(sendTwoLink) withObject:nil afterDelay:2];
    
    
}
-(void)sendTwoLink
{
    [self loadDataWithHeadPath:[NSString stringWithFormat:TwoNewUrl,self.path]];
    
}
-(void)loadDataWithHeadPath:(NSString*)path
{
    
    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseHeadDataWithSource:responseObject];
        [self.tableView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self.tableView footerEndRefreshing];
        [MMProgressHUD dismissWithError:@"error"];
         
    }];
}
-(void)paseHeadDataWithSource:(id)path
{
    self.path = path[@"next"];
    NSArray *array = path[@"list"];
       
    [self.dataSource addObjectsFromArray:[NewsModel arrayOfModelsFromDictionaries:array]];
    [self.tableView reloadData];
    [MMProgressHUD dismissWithSuccess:@"ok"];
    
}
-(NSMutableArray*)headArray
{
    if (_headArray==nil) {
        _headArray = [[NSMutableArray alloc]init];
    }
    return _headArray;
}
-(void)loadHeadData
{
    [self sendIn:ScrollUrl];
//    [self.manager GET:ScrollUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self sendSource:responseObject];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
}
-(void)loadData
{
    [MMProgressHUD setPresentationStyle: MMProgressHUDPresentationStyleBalloon];
    //    设置显示的内容
    [MMProgressHUD showDeterminateProgressWithTitle:@"下载中" status:@"loading"];
    
    [self performSelector:@selector(sendLink) withObject:nil afterDelay:2];
//    [self loadDataWithPath:[NSString stringWithFormat:TwoNewUrl,1]];
}
-(void)sendLink
{
    [self loadDataWithPath:[NSString stringWithFormat:NewUrl]];
}
-(void)loadDataWithPath:(NSString *)path
{
  
    
    
    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseData:responseObject];
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultFailure];
    }];
}
-(void)sendIn:(NSString*)path
{
    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self sendSource:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
-(void)sendSource:(id)responseObject
{
    NSArray * array = responseObject[@"list"];
    if (self.headArray.count>0) {
        [self.headArray removeAllObjects];
    }
    [self.headArray addObjectsFromArray:[NewsModel arrayOfModelsFromDictionaries:array]];
    [self.tableView reloadData];
    
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
    return self.dataSource.count;
    }
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    switch (indexPath.section) {
        case 0:
            cell = [self tableView:tableView imageCellForRowAtIndexPath:indexPath];
            break;
        case 1:
            cell = [self tableView:tableView customCellForRowAtIndexPath:indexPath];
            break;
            
        default:
            break;
                }
    return cell;
}
-(UITableViewCell*)tableView:(UITableView *)tableView customCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:self options:nil][0];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NewsModel * model = self.dataSource[indexPath.row];
    cell.model = model;
    return cell;
}
-(UITableViewCell*)tableView:(UITableView *)tableView imageCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"acell"];
    if (cell==nil) {
        cell = [[ImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"acell"];
    }
    cell.itemSelect = ^(NSInteger index)
    {
        [self click:index];
    };
    cell.imageObjects = self.headArray;
    return cell;
}
-(void)click:(NSInteger)index
{
    NewsWebViewController * new = [[NewsWebViewController alloc]init];
    NewsModel * model = nil;
    for (int i= 0;i<index ; i++) {
        
        if (index==0) {
            model = [self.headArray lastObject];
        }else if (index==5)
        {
            model = [self.headArray firstObject];
        }else
        {
            model = self.headArray[index-1];
        }
        
    }
    if ([model.is_direct isEqualToString:@"True"]==YES  ) {
        new.link = model.article_url;
    }else
    {
        new.link = [NSString stringWithFormat:@"http://101.226.76.163/static/pages/news/phone/%@?APP_BROWSER_VERSION_CODE=1&android_version=1&imgmode=auto",model.article_url];
    }
    [self.navigationController pushViewController:new animated:YES];
    
   }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return KImageCell_Height;
    }
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
