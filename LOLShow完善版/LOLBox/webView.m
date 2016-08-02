//
//  webView.m
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "webView.h"

@interface webView ()

@end

@implementation webView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}
-(void)createUI

{
    self.title = @"资讯详情";
        UIWebView *view = [[UIWebView alloc]initWithFrame:self.view.bounds];
    view.delegate = self;
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.str]]];
    
    [self.view addSubview:view];
    
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //是否允许加载某个request
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
