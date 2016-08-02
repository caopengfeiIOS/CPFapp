//
//  HeroSearchViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "HeroSearchViewController.h"
#import "HeroNameViewController.h"
@interface HeroSearchViewController ()
{
    UITextField * _textFiled;
    UITextField *_text;
}
@end

@implementation HeroSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}
-(void)createUI
{
    UIImageView * imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Size.width, KScreen_Size.height)];
    imageView.image = [UIImage imageNamed:@"LaunchImage@2x"];
    [self.view addSubview:imageView];
    float Gap = 30;
    float Width = KScreen_Size.width-Gap*2;
    float Height = 40;
    _textFiled = [[UITextField alloc]initWithFrame:CGRectMake(Gap, 40, Width, Height)];
    _text = [[UITextField alloc]initWithFrame:CGRectMake(Gap, 100, Width, Height)];
    _textFiled.borderStyle = UITextBorderStyleLine;
    _text.borderStyle = UITextBorderStyleLine;
    _textFiled.backgroundColor = [UIColor whiteColor];
    _text.backgroundColor = [UIColor whiteColor];
    _textFiled.clearsOnBeginEditing = YES;
    _text.clearsOnBeginEditing = YES;
    _textFiled.placeholder = @"请输入大区";
    _text.placeholder = @"请输入游戏ID";
     //bindSearch1
    CGFloat BWidth = KScreen_Size.width-4*Gap;
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(2*Gap, 150, BWidth, Height)];
    [button setImage:[UIImage imageNamed:@"bindSearch1"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self.view addSubview:_text];
    [self.view addSubview:_textFiled];
}
-(void)buttonClicked:(UIButton*)button
{
    HeroNameViewController * vc = [[HeroNameViewController alloc]init];
    vc.name = _textFiled.text;
    vc.ID = _text.text;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_text resignFirstResponder];
    [_textFiled resignFirstResponder];
}

-(void)addUI{};
-(void)addSearchBar{};
-(void)loadData{};
@end
