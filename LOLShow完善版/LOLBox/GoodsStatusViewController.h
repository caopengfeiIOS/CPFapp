//
//  GoodsStatusViewController.h
//  LOLBox
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "CPFRootViewController.h"
#import "GoodsModel.h"
@interface GoodsStatusViewController : CPFRootViewController
@property (nonatomic,copy) NSString * link;
@property (nonatomic,copy) NSString * imageName;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) GoodsModel * model;


@end
