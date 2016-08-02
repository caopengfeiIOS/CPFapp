//
//  HeroViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "HeroViewController.h"
#import "SCNavTabBarController.h"
#import "AllHeroViewController.h"
#import "FreeViewController.h"
@interface HeroViewController ()

@end

@implementation HeroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self makeNavigationBar];
}
-(void)addUI{};
-(void)addSearchBar{};
-(void)loadData{};
-(void)makeNavigationBar
{
    AllHeroViewController * hero = [[AllHeroViewController alloc]init];
    hero.title = @"全部英雄";
    FreeViewController * free = [[FreeViewController alloc]init];
    free.title = @"周免英雄";
    SCNavTabBarController * sc = [[SCNavTabBarController alloc]init];
    sc.subViewControllers = @[hero,free];
    sc.navTabBarColor = [UIColor whiteColor];
    [sc addParentController:self];

}


@end
