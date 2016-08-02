//
//  ScanViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "JumpViewController.h"
@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *layer
;
@property (nonatomic,copy) NSString * path;

@property (nonatomic, assign) BOOL isUp;

@end

@implementation ScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.title = @"二维码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    [self createQrCode];
    
}

- (void)createUI
{
    
    // 创建背景框
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200) * 0.5, (self.view.frame.size.height - 264) * 0.5, 200, 200)];
    bgView.image = [UIImage imageNamed:@"HR_border"];
    [self.view addSubview:bgView];
    
    
    // 创建扫描线
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 200) * 0.5, (self.view.frame.size.height - 200) * 0.5, 200, 20)];
    lineView.image = [UIImage imageNamed:@"HR_scan_line"];
    [self.view addSubview:lineView];
    _lineView = lineView;
    
    
    // 增加动画
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(showAnim)];
    _displayLink = displayLink;
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

// 动画
- (void)showAnim
{
    
    CGFloat lineY = _lineView.frame.origin.y;
    
    if (_isUp) {
        
        lineY --;
        _lineView.transform = CGAffineTransformMakeRotation(M_PI);
        
    }else {
        
        _lineView.transform = CGAffineTransformIdentity;
        lineY ++;
        
    }
    
    if (lineY > (self.view.frame.size.height + 200) * 0.5 - 20){
        
        _isUp = YES;
        
    }else if (lineY < (self.view.frame.size.height - 200) * 0.5){
        
        _isUp = NO;
        
    }
    
    _lineView.frame = CGRectMake((self.view.frame.size.width - 200) * 0.5, lineY, 200, 20);
}


// 添加二维码
- (void)createQrCode
{
    
    // 1.拿到输入设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2.设置输入
    NSError *error = nil;
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error) {
        
        UIAlertView * alterView = [[UIAlertView alloc]initWithTitle:@"未发现摄像头" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alterView.tag = 10;
        [alterView show];
        
    }else {
        
        // 3.设置输出
        
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        
        // 3.1设置输出回调
        
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // 4.创建会话
        
        _session = [[AVCaptureSession alloc] init];
        
        // 4.1添加输入
        
        [_session addInput:input];
        
        // 4.2输出
        
        [_session addOutput:output];
        
        // 5.设置输出格式(扫描识别格式)
        
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
        
        // 7.增加透视层
        
        AVCaptureVideoPreviewLayer *layer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
        _layer = layer;
        layer.frame = self.view.bounds;
        [self.view.layer insertSublayer:layer atIndex:0];
        
        
        // 6.开始扫描
        
        [_session startRunning];
        
    }
    
}


- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    if (metadataObjects.count > 0) {
        
        [_session stopRunning];
        
        _displayLink.paused = YES;
        
        [_layer removeFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *obj = [metadataObjects lastObject];
        
        NSString *string = obj.stringValue;
        
        // @"tecent: www.baidu.com"
        
        _path = string;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:string delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", @"取消", nil];
        alert.tag = 20;
        
        [alert show];
        
    }
}

// alertview的代理方法

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (alertView.tag) {
        case 10:
            NSLog(@"相机");
            
            switch (buttonIndex) {
                case 0:
                {
                    
                    [_session startRunning];
                    _displayLink.paused = NO;
                    
                    [self.view.layer insertSublayer:_layer atIndex:0];
                    
                }
                    break;
                    
                case 1:
                    
                    break;
                    
                default:
                    
                    break;
            }
            
            
            break;
        case 20:
        {
            NSLog(@"跳转");
            switch (buttonIndex) {
                    
                case 0:
                {
                    
                    JumpViewController * jump = [[JumpViewController alloc]init];
                    [self.navigationController pushViewController:jump animated:YES];
                    
                }
                    break;
                    
                case 1:
                    
                    break;
                    
                default:
                    
                    break;
            }
            
            break;
        }
        default:
            break;
    }
    
    
    
    
    
    
    
}

@end
