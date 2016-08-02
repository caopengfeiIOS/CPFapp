//
//  HeroCell.m
//  LOLBox
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "HeroCell.h"
#import "HeroModel.h"
#import "UIImageView+WebCache.h"
@implementation HeroCell

-(void)setModel:(HeroModel *)model
{
    _model = model;
    [_heroImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
    _firstLabel.text = model.title;
    _secondLabel.text = model.name_c;
    NSArray * array =[model.tags componentsSeparatedByString:@","];
    NSMutableString * string = [[NSMutableString alloc]init];
    for (int i=0; i<array.count; i++) {
        NSString * str = array[i];
        NSString * str2 = @" ";
        [string appendString:str];
        [string appendString:str2];
    }
        
    _thirdLabel.text = string;
//    _thirdLabel.text = model.
}
@end
