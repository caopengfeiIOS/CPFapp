//
//  NewsWebViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "NewsWebViewController.h"

@interface NewsWebViewController ()<UIWebViewDelegate>

@end

@implementation NewsWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUI];
    
}
-(void)addUI
{
    UIWebView * view = [[UIWebView alloc]initWithFrame:self.view.bounds];
    view.delegate  = self;
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.link]]];
    [self.view addSubview:view];
    }
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //是否允许加载某个request
    return YES;
}



@end
