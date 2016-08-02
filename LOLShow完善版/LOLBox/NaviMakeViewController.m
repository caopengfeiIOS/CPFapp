//
//  NaviMakeViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/13.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "NaviMakeViewController.h"
#import "SCNavTabBarController.h"
#import "NewsViewController.h"
#import "MovieViewController.h"
#import "CapturingViewController.h"
#import "OfficialViewController.h"
#import "EssenceViewController.h"
#import "FunViewController.h"
#import "EventViewController.h"
@interface NaviMakeViewController ()

@end

@implementation NaviMakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self makeNavigationBar];
}

-(void)makeNavigationBar
{
    
    NewsViewController * new = [[NewsViewController alloc]init];
//    new.navigationItem.titleView = []
    new.title = @"最新";
    CapturingViewController * cap = [[CapturingViewController alloc]init];
    cap.title = @"攻略";
    
    
    OfficialViewController * off = [[OfficialViewController alloc]init];
    off.title = @"官方";
    EssenceViewController * ess = [[EssenceViewController alloc]init];
    ess.title = @"精华";
    EventViewController * event = [[EventViewController alloc]init];
    event.title =@"赛事";
    FunViewController * fun = [[FunViewController alloc]init];
    fun.title =@"娱乐";
    MovieViewController * movie = [[MovieViewController alloc]init];
    movie.title =@"视频";
    
    SCNavTabBarController * sc = [[SCNavTabBarController alloc]init];
    sc.subViewControllers = @[new,event,movie,fun,off,cap,ess];
    sc.showArrowButton = YES;
    [sc addParentController:self];
    
    
    
}

@end
