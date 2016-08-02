//
//  PaperCollectionViewCell.h
//  LOLBox
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PaperModel;
@interface PaperCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) PaperModel * model;
@property(nonatomic,strong)UIImageView *picImageView;
@property (nonatomic,copy) void(^sendMessage)();
@end
