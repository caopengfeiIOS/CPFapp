//
//  JumpViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "JumpViewController.h"
#import "MBProgressHUD.h"
@interface JumpViewController ()<UIWebViewDelegate>
@property (nonatomic,copy) NSString * path;
@end

@implementation JumpViewController

- (NSOperationQueue *)quene{
    
    if (!_quene) {
        
        self.quene = [[NSOperationQueue alloc]init];
        
    }
    
    return _quene;
}

- (UIWebView *)webview{
    
    if (!_webview) {
        
        self.webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        self.webview.delegate = self;
        
        [self.view addSubview:_webview];
        
        
    }
    
    return _webview;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",_path);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self reloadData];
    // Do any additional setup after loading the view.
}
- (void)reloadData{
    
    __weak typeof (self)weakSelf = self;
    NSBlockOperation * operation = [NSBlockOperation blockOperationWithBlock:^{
        NSString * url = _path;
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        
        // 回到主线程刷新webview
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [weakSelf.webview loadRequest:request];
            _webview.hidden = NO;
        }];
        
    }];
    
    [self.quene addOperation:operation];
    
}

#pragma mark --------WebView代理方法

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    return YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}


@end
