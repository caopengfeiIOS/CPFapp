//
//  NewsTableViewCell.m
//  LOLBox
//
//  Created by qianfeng on 15/12/12.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setModel:(NewsModel *)model
{
    _model = model;
    [_gameLabel sd_setImageWithURL:[NSURL URLWithString:model.image_url_small]];
    _firstLabel.text = model.title;
    _secondLabel.text = model.summary;
    _secondLabel.numberOfLines = 0;
    _secondLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
//    _thirdLabel.text = model.insert_date;
    NSArray *array = [model.insert_date componentsSeparatedByString:@" "];
    NSString * str = array[1];
    _thirdLabel.text = str;
    _thirdLabel.textAlignment = NSTextAlignmentRight;
   }


@end
