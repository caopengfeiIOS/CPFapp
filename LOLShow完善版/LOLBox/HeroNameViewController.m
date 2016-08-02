//
//  HeroNameViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "HeroNameViewController.h"

@interface HeroNameViewController ()

@end

@implementation HeroNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
}
-(void)createUI
{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSString * url = [NSString stringWithFormat:HeroSearchUrl,self.name,self.ID];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   [ webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.view addSubview:webView];

}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}
-(void)addUI{};
-(void)addSearchBar{};
-(void)loadData{};
@end
