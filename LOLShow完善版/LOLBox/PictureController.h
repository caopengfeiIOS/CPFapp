//
//  PictureController.h
//  LOLBox
//
//  Created by qianfeng on 15/12/15.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "CPFRootViewController.h"
#import "PaperModel.h"
@interface PictureController : CPFRootViewController<UMSocialUIDelegate>
@property (nonatomic,strong)PaperModel * model ;
@property (nonatomic,strong) NSArray * imagesArray;
@property (nonatomic,copy) NSString * link;
 
@end
