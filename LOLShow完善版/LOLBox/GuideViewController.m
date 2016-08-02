//
//  GuideViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/20.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "GuideViewController.h"
#import "CPFTabViewController.h"
@interface GuideViewController ()

@end

@implementation GuideViewController
//LaunchImage@2x
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    
    UIImageView * imageView=[[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    imageView.image=[UIImage imageNamed:@"LaunchImage@2x"];
    imageView.userInteractionEnabled=YES;
    
    
    
    
    
    
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake((KScreen_Size.width-80)/2, KScreen_Size.height*2/3, 80, 40)];
    
    button.backgroundColor=[UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:0.7];
    
    [button setTitle:@"Enter" forState:UIControlStateNormal];
    
    button.layer.cornerRadius=20;
    
    button.layer.masksToBounds=YES;
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [imageView addSubview:button];
    
    [self.view addSubview:imageView];
}

- (void)buttonClick
{
    
    CPFTabViewController *tab=[[CPFTabViewController alloc]init];
    
    self.view.window.rootViewController=tab;
    
    
}
@end
