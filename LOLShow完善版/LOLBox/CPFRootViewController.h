//
//  CPFRootViewController.h
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "MJRefresh.h"
@interface CPFRootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,UISearchBarDelegate>
-(void)setNavigationBar;
-(void)setNavigationItem;
@property (nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic,strong) AFHTTPRequestOperationManager * manager;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,copy) NSString *searchPath;
@property (nonatomic,strong) MJRefreshHeaderView *headView;
@property (nonatomic,strong) MJRefreshFooterView *footView;
@property (nonatomic,assign) int currentPage;
@property (nonatomic,copy) NSString * path;
@property (nonatomic,copy) NSString * headPath;
@property (nonatomic,strong) UITableView * tableView;
-(void)loadData;
-(void)paseData:(id)data;
- (void)loadDataWithPath:(NSString*)path;
-(void)addSearchBar;

-(void)addUI;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@property (nonatomic,assign) int pageIndex;

@end
