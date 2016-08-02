//
//  EventViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "EventViewController.h"
#import "MJRefresh.h"
#import "NewsModel.h"
@interface EventViewController ()

@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self startViewController];
}
-(void)startViewController
{
    __weak EventViewController * new = self;
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
    [self loadDataWithHeadPath:[NSString stringWithFormat:TwoCompetitoinUrl,self.path]];
    
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
    [self loadDataWithPath:[NSString stringWithFormat:CompetitoinUrl,1]];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

//-(void)loadData
//{
//    [self loadDataWithPath:CompetitoinUrl];
//}
@end
