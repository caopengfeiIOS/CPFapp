//
//  PictureController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "PictureController.h"
#import "UIImageView+WebCache.h"
#import "LodaView.h"
#import "DBManager.h"
@interface PictureController ()<UIScrollViewDelegate>


@property(nonatomic,strong)UIScrollView * scrollView;
@end

@implementation PictureController
{
    NSInteger _index;
    LodaView *_loadView;
    NSInteger _otherIndex;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGesture];
//    self.navigationController.navigationBar.translucent = YES;
    
   
}
//-(LodaView*)loadView
//{
//    if (_loadView==nil) {
//        _loadView =[[LodaView alloc]initWithFrame:CGRectMake(0, 500, KScreen_Size.width, 150)];
//    }
//    return _loadView;
//}
-(void)loadData
{
    _loadView = [[LodaView alloc]initWithFrame:CGRectMake(0, (KScreen_Size.height/2)*1.53, KScreen_Size.width, KScreen_Size.height/4)];
    NSArray * titleArray=@[@"保存",@"收藏",@"分享"];
    
    NSArray * imageNormal = @[@"hero_btn_update_right_bar_normal",@"fav_hero_normal@2x",@"nav_touch_with_me_info_normal@2x"];
    NSArray * imageSelect = @[@"hero_btn_update_right_bar_press@2x",@"fav_hero_selected@2x",@"nav_touch_with_me_info_press@2x"];
    float GAP = 20;
    //    fav_hero_selected@2x
    float Width = (KScreen_Size.width-4*GAP)/3;
    for (int i=0; i<titleArray.count; i++) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(GAP+(Width+GAP)*i, 50, Width, 40)];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        button.tag = i+101;
        [button setImage:[UIImage imageNamed:imageNormal[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imageSelect[i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicke:) forControlEvents:UIControlEventTouchUpInside];
        [_loadView addSubview:button];
    }

        [self.view addSubview:_loadView];
}
-(void)buttonClicke:(UIButton*)button
{
    NSInteger index = button.tag - 101;
    if (index==1) {
        if (button.selected==YES) {
            button.selected =NO;
            [button setImage:[UIImage imageNamed:@"fav_hero_normal@2x"] forState:UIControlStateNormal];
            
        }else{
            button.selected = YES;
            [button setImage:[UIImage imageNamed:@"fav_hero_selected@2x"] forState:UIControlStateNormal];
            [self saveData];
        }
    }
    if (index==0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:@"此功能尚未实现敬请期待" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    if (index==2) {
//        PaperModel * model = self.imagesArray[_otherIndex];
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@""
                                          shareText:@"#我在用LolBoxAPP分享"
                                         shareImage:[UIImage imageNamed:@"58x58.jpg"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
                                           delegate:self];
    }
}
-(void)saveData
{
    DBManager * manager = [DBManager defaultDBManager];
    
    PaperModel * model = self.imagesArray[_otherIndex];
    model.nub = @"0";
    [manager saveAppDetailModel:model];
}
-(UIScrollView*)scrollView
{
    if (_scrollView==nil) {
        _scrollView =[[UIScrollView alloc]initWithFrame:self.view.bounds];
        _scrollView.delegate =self;
    }
    return _scrollView;
}
-(void)addUI
{
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*self.imagesArray.count, _scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    for (int i=0; i<self.imagesArray.count; i++) {
        PaperModel * model = self.imagesArray[i];
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(self.scrollView.frame.size.width*i, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.url]];
        self.scrollView.directionalLockEnabled = YES;
        [self.scrollView addSubview:imageView];
       
    }
      _index = [self.imagesArray indexOfObject:self.model];
     self.scrollView.contentOffset = CGPointMake(_index*self.scrollView.frame.size.width, 0);
   
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _otherIndex = scrollView.contentOffset.x/scrollView.bounds.size.width;
    [self createUI:_otherIndex];
    
}
-(void)createUI:(NSInteger)index
{

    PaperModel * model = self.imagesArray[_otherIndex];
    _loadView.model = model;
    
}

-(void)addGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}
-(void)tap:(UIGestureRecognizer*)tap
{
    if (self.navigationController.navigationBarHidden == YES) {
        self.navigationController.navigationBarHidden = NO;
        [[UIApplication sharedApplication]setStatusBarHidden:NO];
    }else
    {
        self.navigationController.navigationBarHidden = YES;
        [[UIApplication sharedApplication]setStatusBarHidden:YES];
        
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    PaperModel * model = self.imagesArray[_index];
    _loadView.model = model;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}


@end
