//
//  CPFTabViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "CPFTabViewController.h"

@interface CPFTabViewController ()
@property (nonatomic,strong) NSMutableArray *viewController;
@end

@implementation CPFTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabBar];
    [self setVC];
    [self createBarItems];
    
}
-(NSMutableArray*)viewController
{
    if (_viewController==nil) {
        _viewController = [NSMutableArray new];
    }
    return _viewController;
}
-(void)createTabBar
{
    self.tabBar.barTintColor = [UIColor whiteColor];
}
-(void)setVC
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"资讯",@"喜欢",@"发现",@"设置"];
    NSArray * controllers = @[@"NaviMakeViewController",@"FrindViewController",@"SearchViewController",@"SetViewController"];
    for (int i=0; i<titles.count; i++) {
        Class class = NSClassFromString(controllers[i]);
        UIViewController *vc = [[class alloc]init];
        vc.title = titles[i];
        
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
        [self.viewController addObject:navi];

    }
    self.viewControllers = self.viewController;
 }
-(void)createBarItems
{
     NSArray *titles = @[@"资讯",@"喜欢",@"发现",@"设置"];
    NSArray * images = @[@"tab_icon_news_normal@2x",@"tab_icon_friend_normal@2x",@"tab_icon_quiz_normal@2x",@"tab_icon_more_normal@2x"];
    NSArray * selectedImages = @[@"tab_icon_news_press@2x",@"tab_icon_friend_press@2x",@"tab_icon_quiz_press@2x",@"tab_icon_more_press@2x"];

    for (int i=0;i<titles.count ; i++) {
        UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:titles[i]    image:[[UIImage imageNamed:images[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  selectedImage:[[UIImage imageNamed:selectedImages[i] ] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        UIViewController * vc = self.viewControllers[i];
        //tabBarItem是属于TabBarController的子视图控制器的
        vc.tabBarItem = item;

    }
}

@end
