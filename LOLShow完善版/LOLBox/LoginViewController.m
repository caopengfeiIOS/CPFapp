//
//  LoginViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "UMSocial.h"
@interface LoginViewController ()
{
    UIImageView * _myImageView;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       [self createButton];
}
- (void)createButton
{
    _myImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Size.width, KScreen_Size.height)];
    UIImage * image = [UIImage imageNamed:@"2_4.jpg"];
    _myImageView.image = image;
    [self.view addSubview:_myImageView];
    _myImageView.userInteractionEnabled = YES;

    UITextField *tf1=[[UITextField alloc]init];
    
    tf1.frame=CGRectMake(20, 70, KScreen_Size.width-40, 40);
    
    tf1.tag=11;
    tf1.layer.borderColor=[UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:1].CGColor;
    tf1.layer.borderWidth=1;
    
    tf1.placeholder=@"账号";
    
    [self.view addSubview:tf1];
    
    
    UITextField *tf2=[[UITextField alloc]init];
    
    tf2.frame=CGRectMake(20, CGRectGetMaxY(tf1.frame)+20, KScreen_Size.width-40, 40);
    
    tf2.tag=12;
    tf2.layer.borderColor=[UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:1].CGColor;
    tf2.layer.borderWidth=1;
    
    tf2.secureTextEntry=YES;
    tf2.clearsOnBeginEditing=YES;
    tf2.placeholder=@"密码";
    
    [self.view addSubview:tf2];
    
    
    UIButton *button=[[UIButton alloc]init];
    
    
    button.frame=CGRectMake(80, CGRectGetMaxY(tf2.frame)+20, KScreen_Size.width-160, 40);
    
    button.layer.borderWidth=1;
    button.layer.borderColor=[UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:0.7].CGColor;
    button.tag=22;
    [button setTitle:@"登录" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:0.7];
    [button addTarget:self  action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:button];
    
    
    UIButton *queren=[[UIButton alloc]init];
    
    queren.backgroundColor = [UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:0.7];
    queren.frame=CGRectMake(80, CGRectGetMaxY(button.frame)+20, KScreen_Size.width-160, 40);
    
    queren.tag=23;
//    queren.backgroundColor=[UIColor colorWithRed:204/255.0 green:170/255.0 blue:119/255.0 alpha:1];
    
    [queren setTitle:@"注册" forState:UIControlStateNormal];
    [queren addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [queren setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:queren];
    
    
    UIButton *sanfang=[[UIButton alloc]init];
    
    
    sanfang.frame=CGRectMake(80, CGRectGetMaxY(queren.frame)+20, KScreen_Size.width-160, 40);
    
    [sanfang addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    sanfang.backgroundColor=[UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:0.7];
    
    [sanfang setTitle:@"第三方登录" forState:UIControlStateNormal];
    sanfang.tag=24;
    [sanfang setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:sanfang];
    
}
-(void)buttonClick:(UIButton*)button
{
    if (button.tag==22) {
        [self enterView];
    }
    if (button.tag==23) {
        RegistViewController * regist = [[RegistViewController alloc]init];
        [self presentViewController:regist animated:NO completion:nil];
    }
    if (button.tag==24) {
        UMSocialSnsPlatform * snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity * response){
            if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
             if (self.sendInfo) {
                 self.sendInfo(snsAccount.iconURL,snsAccount.userName);
             }
            }
             [self.navigationController popViewControllerAnimated:NO];
        });

    }
}
-(void)enterView
{
    UITextField *tfName=(id)[self.view viewWithTag:11];
    UITextField *tfPass=(id)[self.view viewWithTag:12];
    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    
    NSArray *arr=[user objectForKey:@"user"];
    for (NSDictionary *dic in arr) {
        
        if ([dic[@"username"]isEqualToString:tfName.text]==YES) {
            
            
            if ([dic[@"password"]isEqualToString:tfPass.text]==YES) {
                
                if (self.sendMessage) {
                    
                    self.sendMessage(dic[@"username"]);
                }
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                
                
            }else
                
            {
                
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"密码错误" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
                
                
                return;
                
            }
            
        }
        
    }
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"账户名不存在" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    return;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
