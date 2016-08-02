//
//  GuanFangViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "GuanFangViewController.h"

@interface GuanFangViewController ()

@end

@implementation GuanFangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}
-(void)addUI{};
-(void)addSearchBar{};
-(void)loadData{};
-(void)createUI
{
    UIWebView * view = [[UIWebView alloc]initWithFrame:self.view.bounds];
    view.tag = 55;
    view.delegate = self;
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:LunTanUrl]]];
    [self.view addSubview:view];
    UIButton * button = [[UIButton alloc]init];
    button.frame = CGRectMake(KScreen_Size.width-40, 10, 40, 40);
    [button setTitle:@"后退" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)buttonClicked:(UIButton*)button
{
    UIWebView * web =(id)[self.view viewWithTag:55 ];
    [web goBack];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}



@end
