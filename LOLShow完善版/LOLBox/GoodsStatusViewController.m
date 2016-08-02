//
//  GoodsStatusViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "GoodsStatusViewController.h"

#import "UIImageView+WebCache.h"
@interface GoodsStatusViewController ()
@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UILabel * priceLabel;
@property (nonatomic,strong)UILabel * goodsLabel;
//UILabel * descriptionLabel;
//UILabel * supplyLabel;
//UILabel * listLabel;
//UILabel * heLabel;
//UILabel * helistLabel;

@end

@implementation GoodsStatusViewController
{
    NSMutableDictionary * _dict;
    
    }

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    [self.tableView setBackgroundColor:[UIColor redColor]];
    [self createUI];
    // Do any additional setup after loading the view.
}
//-(void)createUI
//{
//    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
//    
//}
-(void)addSearchBar{};
- (UIImageView*)imageView
{
    if (_imageView ==nil) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 80, 80)];
    }
    return _imageView;
}
-(UILabel*)nameLabel
{
    if (_nameLabel ==nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)+10, self.imageView.frame.origin.y-3, 80, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}
-(UILabel*)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame)+10, CGRectGetMaxY(self.nameLabel.frame)+3, 200, 20)];
        _priceLabel.font = [UIFont systemFontOfSize:14];
    }
    return _priceLabel;
}
-(UILabel *)goodsLabel
{
    if (_goodsLabel==nil) {
        _goodsLabel = [[UILabel alloc]init];
    }
    return _goodsLabel;
}
-(void)createUI
{
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    [self.tableView addSubview:self.imageView];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageName]];
    UILabel * shuxing = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.imageView.frame)+10, 80, 20)];
    shuxing.text = @"物品属性";
//    shuxing.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.8];
    shuxing.textColor =[UIColor colorWithWhite:0.3 alpha:0.8];

    shuxing.font = [UIFont systemFontOfSize:15];
    [self.tableView addSubview:shuxing];
   
    
    

   
    
}
-(void)loadData
{
    [self loadDataWithPath:[NSString stringWithFormat:GoodStatus,self.link]];
}
-(void)paseData:(id)data
{
   
    _dict  = [NSMutableDictionary dictionary];
    [_dict addEntriesFromDictionary:data];
    self.nameLabel.text = _dict[@"name"];
    NSLog(@"%@",_dict[@"name"]);
    [self.tableView addSubview:self.nameLabel];
    self.priceLabel.text = [NSString stringWithFormat:@"价格:%@ 总价:%@ 售价:%@",_dict[@"price"],_dict[@"allPrice"],_dict[@"sellPrice"]];
    [self.tableView addSubview:self.priceLabel];
   
   
    self.goodsLabel.text = _dict[@"description"];
   
    self.goodsLabel.numberOfLines = 0;
    self.goodsLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.goodsLabel.font = [UIFont systemFontOfSize:15];
    NSDictionary * descAttribute = @{NSFontAttributeName:self.goodsLabel.font};
    CGSize maxSize = CGSizeMake(KScreen_Size.width-10, CGFLOAT_MAX);
    CGSize descSize = [self.goodsLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:descAttribute context:nil].size;
    self.goodsLabel.frame = CGRectMake(10, CGRectGetMaxY(self.imageView.frame)+40, descSize.width, descSize.height);
    [self.tableView addSubview:self.goodsLabel];
    UILabel * spLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.goodsLabel.frame)+5, 40, 20)];
    spLabel.text = @"需求";
    spLabel.font = [UIFont systemFontOfSize:15];
    spLabel.textColor = [UIColor colorWithWhite:0.3 alpha:0.8];
    [self.tableView addSubview:spLabel];
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
    for (int i= 0; i<self.dataArray.count; i++) {
        self.model = self.dataArray[i];
        NSArray *array = [_dict[@"need"]componentsSeparatedByString:@","] ;
        for (NSString * str in array) {
            if ([self.model.ID isEqualToString:str]) {
                [array1 addObject:self.model.icon];
            }
        }
        
    }
        for (int i =0; i<array1.count; i++) {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+70*i, CGRectGetMaxY(self.goodsLabel.frame)+30, 60, 60)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array1[i]]];
         [self.tableView addSubview:imageView];
    }
   
    UILabel * comLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.goodsLabel.frame)+100, 80, 20)];
    comLabel.text = @"可合成";
    comLabel.textColor =  [UIColor colorWithWhite:0.3 alpha:0.8];
    comLabel.font = [UIFont systemFontOfSize:15];
    [self.tableView addSubview:comLabel];
    NSMutableArray *array2 = [[NSMutableArray alloc]init];
    for (int i= 0; i<self.dataArray.count; i++) {
        self.model = self.dataArray[i];
        NSArray *array = [_dict[@"compose"]componentsSeparatedByString:@","] ;
        for (NSString * str in array) {
            if ([self.model.ID isEqualToString:str]) {
                [array2 addObject:self.model.icon];
            }
        }
        
    }
    for (int i =0; i<array2.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+70*i, CGRectGetMaxY(self.goodsLabel.frame)+130, 60, 60)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array2[i]]];
        [self.tableView addSubview:imageView];
    }



    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor colorWithRed:92 green:109 blue:109 alpha:1];
        
    }
    
    return cell;
    }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
