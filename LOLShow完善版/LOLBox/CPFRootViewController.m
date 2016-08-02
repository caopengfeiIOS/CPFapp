//
//  CPFRootViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "CPFRootViewController.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import "webView.h"
#import "SearchBarViewController.h"
#import "Masonry.h"
@interface CPFRootViewController ()


@end

@implementation CPFRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setNavigationItem];
    

    [self addUI];
    [self loadData];
    [self addSearchBar];
//    -(void)loadData;
//    -(void)paseData:(id)data;
//    - (void)loadDataWithPath:(NSString*)path;
   
   
    
    
    
    
}
-(UISearchBar*)searchBar
{
    if (_searchBar==nil) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, KScreen_Size.width, 44)];
        _searchBar.returnKeyType = UIReturnKeySearch;
        _searchBar.searchBarStyle = UISearchBarStyleDefault;
        _searchBar.delegate = self;
//        _searchBar.text = @"输入您搜索的内容";
        _tableView.tableHeaderView = _searchBar;
    }
    return _searchBar;
}
-(void)addSearchBar
{
    [self.tableView addSubview:self.searchBar];
}
#pragma mark -- searchBar
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString * path = [NSString stringWithFormat:SearchUrl,searchBar.text];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    SearchBarViewController *search = [[SearchBarViewController alloc]init];
    search.searchPath = path;
    [self.navigationController pushViewController:search animated:NO];
    [searchBar resignFirstResponder];
    

}
-(AFHTTPRequestOperationManager*)manager
{
    if (_manager==nil) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    }
    return _manager;
}
-(NSMutableArray*)dataSource
{
    if (_dataSource==nil) {
        _dataSource = [[NSMutableArray alloc]init];
        self.currentPage = 1;
        
    }
    return _dataSource;
}
-(UITableView*)tableView
{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(void)loadData
{
//    __weak UITableView *tempTableView = self.tableView;
//    [tempTableView addhe]
    [self loadDataWithPath:NewUrl];
}
-(void)loadDataWithPath:(NSString *)path
{
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleBalloon];
    [MMProgressHUD showDeterminateProgressWithTitle:@"正在努力加载中" status:@"Loading"];
    //添加等待视图
    [MMProgressHUD show];
    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseData:responseObject];
        [MMProgressHUD dismissWithSuccess:@"下载完成，亲"];
//        _currentPage++;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"失败%@",error);
        [MMProgressHUD dismissWithError:@"sorry,@^@"];
    }];
}
-(void)paseData:(id)data
{
    self.path = data[@"next"];
    NSArray *array = data[@"list"];
    if (self.dataSource.count>0) {
        [self.dataSource removeAllObjects];
    }

    [self.dataSource addObjectsFromArray:[NewsModel arrayOfModelsFromDictionaries:array]];
    [self.tableView reloadData];
    [MMProgressHUD dismissWithSuccess:@"ok"];
}
-(void)addUI
{
    [self.view addSubview:self.tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"NewsTableViewCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    NewsModel * model = self.dataSource[indexPath.row];
    cell.model = model;
//    cell.paseInfo = ^()
//    {
//        UIWebView *web = [[UIWebView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
//        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.article_url]]];
//        
//    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)setNavigationBar
{
    self.navigationController.navigationBar.translucent=NO;
    
//     [self.navigationController.navigationBar setBackgroundImage:[ UIImage imageNamed:@"bg_actionbar_320x64@2x"]  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:22/255.0 green:157/255.0 blue:235/255.0 alpha:1];
}
-(void)setNavigationItem
{
//    self.navigationItem.rightBarButtonItem =[UIBarButtonItem alloc]initWithImage:<#(UIImage *)#> style:<#(UIBarButtonItemStyle)#> target:<#(id)#> action:<#(SEL)#>
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NewsModel * model = self.dataSource[indexPath.row];
    webView * web = [[webView alloc]init];
    if ([model.is_direct isEqualToString:@"True"]==YES  ) {
        web.str = model.article_url;
    }else
    {
        web.str = [NSString stringWithFormat:@"http://101.226.76.163/static/pages/news/phone/%@?APP_BROWSER_VERSION_CODE=1&android_version=1&imgmode=auto",model.article_url];
    }
    
    
    [self.navigationController pushViewController:web animated:NO];
       

}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //是否允许加载某个request
    return YES;
}

@end
