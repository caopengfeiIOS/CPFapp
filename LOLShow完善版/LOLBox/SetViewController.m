//
//  SetViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "SetViewController.h"
#import "LoginViewController.h"
#import "collectionViewController.h"
#import "UIImageView+WebCache.h"
#import "MyLocationViewController.h"
@interface SetViewController ()
{
    UIImageView * _headImageView;
    UILabel * _bottomLabel;
}



@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHeadImage];
   
}
-(void)createHeadImage
{
   
    UIImage * image =[UIImage imageNamed:@"2_4.jpg"];
    UIImageView * hImageView = [[UIImageView alloc]init];
    hImageView.frame=CGRectMake((KScreen_Size.width-image.size.width)/2, 80, image.size.width ,200);
    hImageView.image=image;
    _headImageView = [[UIImageView alloc]init];
    _headImageView.frame = CGRectMake((KScreen_Size.width-80)/2, (hImageView.frame.size.height-80)/2, 80, 80);
    _headImageView.image = [UIImage imageNamed:@"default_head@2x"];
    _headImageView.layer.cornerRadius = 35;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    hImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemClicked:)];
    [_headImageView addGestureRecognizer:tap];
    [hImageView addSubview:_headImageView];
    self.tableView.tableHeaderView = hImageView;
    _bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake((KScreen_Size.width-100)/2, (hImageView.frame.size.height-100)/2+100, 100, 20)];
    _bottomLabel.backgroundColor = [UIColor clearColor];
    _bottomLabel.text = @"点击头像登录";
    _bottomLabel.font = [UIFont systemFontOfSize:15];
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    _bottomLabel.textColor = [UIColor whiteColor];
    [hImageView addSubview:_bottomLabel];
    
 }
-(void)itemClicked:(UITapGestureRecognizer*)tap
{
    LoginViewController * login = [[LoginViewController alloc]init];
    login.title = @"登录";
    login.sendInfo = ^(NSString *url,NSString*name)
    {
        [self passUrl:url send:name];
    };
    login.sendMessage = ^(NSString * name)
    {
        _bottomLabel.text = name;
    };
    [self.navigationController pushViewController:login animated:NO];
    
}
-(void)passUrl:(NSString*)url send:(NSString*)name
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    _bottomLabel.text = name;
}
-(void)loadData
{
    [self.dataSource addObjectsFromArray:@[@[@{@"c1":@"我的收藏"},@{@"c1":@"清理缓存"},@{@"c1":@"我的位置"}],@[@{@"c1":@"意见反馈"},@{@"c1":@"退出登录"}]]];
    [self.tableView reloadData];
}
-(void)addSearchBar{};
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section]count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self addUIToCell:cell atIndexPath:indexPath];
    
    return cell;
}
-(void)addUIToCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath
{
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row][@"c1"];
    
    //在第一个cell加线
    if (indexPath.row ==0) {
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(10, 29, KScreen_Size.width-10, 1);
        view.backgroundColor = [UIColor grayColor];
        view.alpha = 0.2;
        [cell.contentView addSubview:view];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)loadDataWithPath:(NSString *)path{};
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        collectionViewController * collection = [[collectionViewController alloc]init];
        collection.title = @"收藏";
        [self.navigationController pushViewController:collection animated:NO];
    }
    if (indexPath.section == 0&&indexPath.row==1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"是否清理缓存？"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定", nil];
        alertView.tag = 1011;
        [alertView show];

    }
    if (indexPath.section == 0&&indexPath.row ==2) {
        MyLocationViewController * location = [[MyLocationViewController alloc]init];
        
        [self.navigationController pushViewController:location animated:NO];
        
        
    }
    if (indexPath.section==1&&indexPath.row ==0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"此功能尚未实现,敬请期待"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
    if (indexPath.section == 1&&indexPath.row ==1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"此功能尚未实现,敬请期待"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
        [alertView show];

        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == 1 &&alertView.tag == 1011)
    {
       
            [self clearCache];
        
    }
}

//清理缓存
-(void) clearCache
{
    dispatch_async(
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       
                       for (NSString *p in files) {
                           NSError *error;
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                           }
                       }
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess)
                                              withObject:nil waitUntilDone:YES];});
}

-(void)clearCacheSuccess
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"缓存清理成功！"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}


@end
