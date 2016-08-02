//
//  RegistViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/21.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addUI];
    
}
-(void)addUI
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Size.width, KScreen_Size.height)];
    imageView.image = [UIImage imageNamed:@"10_15.jpg"];
    [self.view addSubview:imageView];
    NSArray * name = @[@"用户名",@"密码",@"重复密码"];
    for (int i=0; i<name.count; i++) {
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(40, 80+i*64, KScreen_Size.width-80, 44)];
        textField.tag = 55+i;
        textField.placeholder = name[i];
        textField.layer.borderColor =[UIColor blueColor].CGColor;
        textField.layer.borderWidth=1;
        UIView *left=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        textField.leftView=left;
        textField.leftViewMode=UITextFieldViewModeAlways;
        
        //密码框设置
        if (i==1||i==2) {
            textField.secureTextEntry=YES;
            textField.clearsOnBeginEditing=YES;
            
            
        }
        //清空按钮
        textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        
        [self.view addSubview:textField];
        
        
    }
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(KScreen_Size.width-80, 40, 80, 40)];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:0.7] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton * sencondButton = [[UIButton alloc]initWithFrame:CGRectMake(30, 40, 80, 40)];
    [sencondButton setTitle:@"返回" forState:UIControlStateNormal];
    [sencondButton addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [sencondButton setTitleColor:[UIColor colorWithRed :32/255.0 green:64/255.0 blue:106/225.0 alpha:0.7] forState:UIControlStateNormal];
    [self.view addSubview:sencondButton];
    
}
-(void)itemClicked:(UIButton*)button
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)buttonClicked:(UIButton*)button
{
    UITextField * tf1 = (id)[self.view viewWithTag:55];
     UITextField * tf2 = (id)[self.view viewWithTag:56];
     UITextField * tf3 = (id)[self.view viewWithTag:57];
    NSString * string = tf1.text;
    for (int i = 0; i < string.length; i++) {
        unichar ch = [string characterAtIndex:i];
        if (isalnum(ch)==NO) {
            
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"用户名只能由英文和数字构成" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            return;
            
            
            
            
        }
    }
    if ([tf2.text isEqualToString:tf3.text]==NO) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"两次输入密码不一样" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    //   else if
    else if ([tf1.text isEqualToString:@""]==YES)
    {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"用户名不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
         return;
     }
    
    else if ([tf2.text isEqualToString:@""]==YES)
    {
        
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"密码不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
          return;
      }
    //
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"注册成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
         NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
         NSArray *array1=[user objectForKey:@"user"];
          NSDictionary *dict=@{@"username":tf1.text,@"password":tf2.text};
        NSMutableArray *array=[[NSMutableArray alloc]initWithArray:array1];
        [array addObject:dict];
         [user setObject:array forKey:@"user"];
          [self dismissViewControllerAnimated:NO completion:nil];
     }];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:NO completion:nil];
 }

    




@end
