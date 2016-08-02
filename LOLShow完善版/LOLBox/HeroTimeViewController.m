//
//  HeroTimeViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "HeroTimeViewController.h"

@interface HeroTimeViewController ()<UIWebViewDelegate>

@end

@implementation HeroTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.view.backgroundColor = [UIColor grayColor];
}
-(void)createUI
{
    UIWebView * view = [[UIWebView alloc]initWithFrame:self.view.bounds];
    view.delegate = self;
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:HeroTimeUrl]]];
    view.tag = 88;
    [self.view addSubview:view];
   
          UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(5, 0, 40, 20)];
    [button setTitle:@"后退" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:button];
    button.tag = 99;
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(KScreen_Size.width-50, 0, 50, 20)];
    [button1 setTitle:@"退出QQ" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
     button1.titleLabel.font = [UIFont systemFontOfSize:13];
    [button1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button1.tag = 77;
    [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}
-(void)buttonClicked:(UIButton*)button
{
    UIWebView * web = (id)[self.view viewWithTag:88];
    if (button.tag==99) {
        [web goBack];
    }
    if (button.tag==77) {
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:HeroTimeUrl]]];
    }
    
//    [web goBack];
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

-(void)loadData{};
-(void)paseData:(id)data{};
- (void)loadDataWithPath:(NSString*)path{};
-(void)addSearchBar{};
-(void)addUI{};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
