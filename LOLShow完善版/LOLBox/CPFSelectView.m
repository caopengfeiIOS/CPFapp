//
//  CPFSelectView.m
//  LOLBox
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//
#define H_gap 0
#define V_gap 0
#import "CPFSelectView.h"

@implementation CPFSelectView
{
    UIView * _bgView;  //灰色的背景框
    UIView * _slideView;  //滑动的白色view
    
    NSMutableArray * _buttons;
}

//重新构造方法，添加需要添加的子视图，实例化需要实例化的数据源

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initDataSource];
        [self addUI];
        
    }
    return self;
}

-(void)initDataSource
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
}

-(void)addUI
{
    //设置背景颜色
    self.backgroundColor = [UIColor whiteColor];
    
    CGSize size = self.frame.size;
    
    //添加灰色的背景
    _bgView = [[UIView alloc]init];
    _bgView.frame = CGRectMake(H_gap, V_gap, size.width-H_gap*2, size.height-V_gap*2);
    _bgView.backgroundColor = [UIColor redColor];
    _bgView.layer.cornerRadius = 4;
    _bgView.layer.masksToBounds = YES;
    [self addSubview:_bgView];
    
    //添加滑动的白块
    
    _slideView = [[UIView alloc]init];
    _slideView.backgroundColor = [UIColor whiteColor];
    _slideView.layer.cornerRadius = 4;
    _slideView.layer.masksToBounds = YES;
    [_bgView addSubview:_slideView];
    
    
}


//重新属性的set方法，
-(void)setTitles:(NSArray *)titles
{
    //设置滑块的frame
    CGFloat gap = 1;
    CGFloat width = (_bgView.frame.size.width - 2*gap)/titles.count;
    CGFloat height = _bgView.frame.size.height-2*gap;
    
    _slideView.frame = CGRectMake(gap, gap, width, height);
    
    //添加button
    for (int i = 0; i < titles.count; i++) {
        UIButton * button = [[UIButton alloc]init];
        button.frame = CGRectMake(i*width, 0, width, height);
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:30 / 256.0 green:185 / 256.0 blue:230 / 256.0 alpha:1] forState:UIControlStateSelected];
        
        if (i == 0)
            button.selected = YES;
        else
            button.selected = NO;
        
        button.tag = i+11;
        [_bgView addSubview:button];
        [_buttons addObject:button];
        
    }
    
}

-(void)buttonClick:(UIButton*)button
{
    NSInteger index = button.tag - 11;
    
    //1、切换button的显示状态
    for (UIButton * but  in _buttons) {
        if (but == button)
            but.selected = YES;
        else
            but.selected = NO;
        
    }
    
    //2、移动滑块到指定的位置
    [UIView animateWithDuration:0.3 animations:^{
        _slideView.frame = CGRectMake(1+_slideView.frame.size.width*index, 1, _slideView.frame.size.width, _slideView.frame.size.height);
    }];
    
    //把事件传递出去
    
    if (self.selectAtIndex) {
        _selectAtIndex(index);
    }
}



-(void)setSlideViewToOffsexX:(CGFloat)x
{
    //1、获取sliderView的宽度
    CGFloat width = _slideView.frame.size.width;
    CGFloat offsexX = width*x;
    _slideView.frame = CGRectMake(1+offsexX, _slideView.frame.origin.y, _slideView.frame.size.width, _slideView.frame.size.height);
    
    
    //调整button的选中状态
    NSInteger index = x/1;

    
    
    for (int i = 0; i < _buttons.count; i++) {
        UIButton * button =  _buttons[i];
        if (i == index) {
            NSLog(@"11");
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
}



@end
