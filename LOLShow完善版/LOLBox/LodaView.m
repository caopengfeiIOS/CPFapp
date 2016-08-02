//
//  LodaView.m
//  LOLBox
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "LodaView.h"
#import "PaperModel.h"
@implementation LodaView
{
    UILabel *_firstLabel;
    UILabel *_secondLabel;
    UIButton *_setButton;
   
}
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addUI];
    }
    return self;
}
//hero_battle_btn_normal@2x
//fav_hero_normal@2x收藏 fav_hero_selected@2x
//hero_btn_update_right_bar_normal@2x hero_btn_update_right_bar_press@2x 保存
//hero_download_progress_gradient@2x //背景
//nav_touch_with_me_info_normal@2x 分享
//nav_touch_with_me_info_press@2x
-(void)addUI
{
    _firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreen_Size.width-160, 5, 150, 20)];
   
    _secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(KScreen_Size.width-160, 25, 150, 20)];
   
   
    UIImageView *imageciew = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.bounds.origin.y,KScreen_Size.width , self.bounds.size.height)];
    imageciew.image = [UIImage imageNamed:@"hero_download_progress_gradient@2x"];
    [imageciew addSubview:_firstLabel];
    [imageciew addSubview:_secondLabel];
    [self addSubview:imageciew];
    
    
    }
-(void)setModel:(PaperModel *)model
{
    _model = model;
    _firstLabel.text = model.name;
    _secondLabel.text = [NSString stringWithFormat:@"作者:%@",model.author];
    _firstLabel.font = [UIFont systemFontOfSize:15];
    _secondLabel.font = [UIFont systemFontOfSize:14];
    
    
}
@end
