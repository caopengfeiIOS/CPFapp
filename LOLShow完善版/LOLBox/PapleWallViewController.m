//
//  PapleWallViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/14.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "PapleWallViewController.h"
#import "PaperModel.h"
#import "PaperCollectionViewCell.h"
#import "WaterFallLayout.h"
#import "PictureController.h"

@interface PapleWallViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *pixclArray;

@property(nonatomic,assign) NSString * linkPath;
@end

@implementation PapleWallViewController
{
    int currentPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    currentPage = 1;
//    [self sendData];
 }
-(void)sendData
{
    NSString * str = PaperWallUrl;
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleBalloon];
    [MMProgressHUD showDeterminateProgressWithTitle:@"正在努力加载中" status:@"Loading"];
    //添加等待视图
    [MMProgressHUD show];
    [self.manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseData:responseObject];
        [MMProgressHUD dismissWithSuccess:@"下载完成，亲"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MMProgressHUD dismissWithError:@"sorry,@^@"];
    }];
}

-(NSMutableArray*)pixclArray
{
    if (_pixclArray==nil) {
        _pixclArray = [[NSMutableArray alloc]init];
    }
    return _pixclArray;
}

-(void)addSearchBar{};
-(void)addUI
{
    WaterFallLayout *waterFallLayout = [[WaterFallLayout alloc]init];
    waterFallLayout.lineCount = 2;
    waterFallLayout.verticalSpacing = 10;
    waterFallLayout.horizontalSpacing = 10;
    waterFallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionView = [[UICollectionView alloc]initWithFrame:[[UIScreen mainScreen]bounds] collectionViewLayout:waterFallLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[PaperCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    __weak PapleWallViewController * wall = self;
   
    [_collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        
        [wall loadData];
    }];
    [_collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        
       [wall loadDataWithFoot];
    }];
}
-(void)loadDataWithFoot
{
    [MMProgressHUD setPresentationStyle: MMProgressHUDPresentationStyleBalloon];
    //    设置显示的内容
    [MMProgressHUD showDeterminateProgressWithTitle:@"下载中" status:@"loading"];
    [self performSelector:@selector(friendListPost) withObject:nil afterDelay:2];

}
-(void)friendListPost
{
    [self loadDataWithFootPath:TwoPaperWallUrl];
}
-(void)loadDataWithFootPath:(NSString*)path
{
    currentPage++;
    NSString * str = [NSString stringWithFormat:path,currentPage];
//        if ([self.linkPath isEqualToString:@"1"]) {
//            currentPage++;
//        }else
//        {
//            NSLog(@"没有可刷新的");
//            return;
//        }
    [self.manager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseFootDataWithSource:responseObject];
        [_collectionView footerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_collectionView footerEndRefreshing];
        [MMProgressHUD dismissWithError:@"error"];
    }];

}
-(void)paseFootDataWithSource:(id)path
{
    self.linkPath =[NSString stringWithFormat:@"%@",path[@"hasnext"]];
    NSArray * array = path[@"wallpapers"];
    [self.pixclArray addObjectsFromArray:[PaperModel arrayOfModelsFromDictionaries:array]];
    [_collectionView reloadData];
    [MMProgressHUD dismissWithSuccess:@"ok"];
}
-(void)loadData
{
    
    [MMProgressHUD setPresentationStyle: MMProgressHUDPresentationStyleBalloon];
    //    设置显示的内容
    [MMProgressHUD showDeterminateProgressWithTitle:@"下载中" status:@"loading"];
    [self performSelector:@selector(friendListPost1) withObject:nil afterDelay:2];
    
}
-(void)friendListPost1
{
    [self loadDataWithPath:PaperWallUrl];
}
-(void)loadDataWithPath:(NSString *)path
{
//     NSString * str = [NSString stringWithFormat:path,currentPage];
//    if ([self.linkPath isEqualToString:@"1"]) {
//        currentPage++;
//    }else
//    {
//        NSLog(@"没有可刷新的");
//        return;
//    }
    
    
   
    [self.manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self paseData:responseObject];
//        [_collectionView footerEndRefreshing];
        
        [_collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
         [MMProgressHUD dismissWithError:@"sorry,@^@"];
        [_collectionView headerEndRefreshingWithResult:JHRefreshResultFailure];
    }];
}
-(void)paseData:(id)data
{
   
    NSArray * array = data[@"wallpapers"];
    if (self.pixclArray.count>0) {
        [self.pixclArray removeAllObjects];
    }
    [self.pixclArray addObjectsFromArray:[PaperModel arrayOfModelsFromDictionaries:array]];
    [_collectionView reloadData];
     [MMProgressHUD dismissWithSuccess:@"ok"];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.pixclArray.count/2;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PaperCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
     PaperModel *model = self.pixclArray[indexPath.item];
    cell.sendMessage = ^()
    {
        [self passDataWith:model sendDataWith:model.url];
    };
   
    cell.model = model;
    
    
    return cell;
}
-(void)passDataWith:(PaperModel*)model sendDataWith:(NSString*)url
{
    PictureController *pic = [[PictureController alloc]init];
    pic.model = model;
    pic.imagesArray = self.pixclArray;
    pic.link = url;
//    NSLog(@"%@",self.);
    pic.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pic animated:NO];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((375 - 30) / 2, arc4random()%200 + 150);
}

@end
