//
//  GoodsViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/17.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsModel.h"
#import "GoodsCollectionViewCell.h"
#import "GoodsStatusViewController.h"
@interface GoodsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation GoodsViewController
{
    UICollectionView * _collection;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"物品资料";
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)addUI
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(80, 100);
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 20;
    _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 0, KScreen_Size.width-40, KScreen_Size.height-40) collectionViewLayout:layout];
    _collection.dataSource = self;
    _collection.delegate = self;
    [_collection registerClass:[GoodsCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collection.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collection];
    
}
-(void)loadData
{
    [self loadDataWithPath:GoodsUrl];
}
-(void)paseData:(id)data
{
    NSArray * array = data[@"result"];
    NSArray * models = [GoodsModel arrayOfModelsFromDictionaries:array];
    for (int i =0; i<array.count; i++) {
        GoodsModel * model = models[i];
        NSDictionary * dict = array[i];
        model.ID = dict[@"id"];
    }
    [self.dataSource addObjectsFromArray:models];
    [_collection reloadData];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    GoodsModel * model = self.dataSource[indexPath.item];
    cell.model = model;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    GoodsStatusViewController * statu = [[GoodsStatusViewController alloc]init];
//    NSString * path = [NSString stringWithFormat:GoodStatus,model.ID];
//    NSMutableArray * array1 = [[NSMutableArray alloc]init];
//    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        for (int i =0; i<self.dataSource.count; i++) {
//            GoodsModel * model = self.dataSource[i];
//            NSArray *array = [responseObject[@"need"] componentsSeparatedByString:@","];
//            for (NSString * str in array) {
//                if ([model.ID isEqualToString:str]) {
////
//                    [array1 addObject:model.icon];
//                    statu.dataArray = array1;
//                    
//                }
//            }
//           
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//    statu.dataArray = [NSMutableArray arrayWithArray:array1];
    GoodsModel  *models= [[GoodsModel alloc]init];
    statu.model = models;
    statu.dataArray = self.dataSource;
    GoodsModel * model = self.dataSource[indexPath.item];
    
    statu.link = model.ID;
    statu.imageName = model.icon;
    statu.title = model.name;
    [self.navigationController pushViewController:statu animated:NO];
    
}





@end
