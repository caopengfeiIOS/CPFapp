//
//  StatusViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/18.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "StatusViewController.h"
#import "UIImageView+WebCache.h"
@interface StatusViewController ()

@end

@implementation StatusViewController
{
    NSMutableDictionary * _dict;
    UIImageView * _topImageView;
    UIImageView * _headImageView;
    UILabel * _nameLabel ;
    UILabel * _typeLabel;
    UILabel * _sayLabel;
    UILabel * _storyLabel;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.link);
   
    [self createUI];
    
}


-(void)addSearchBar{};
-(void)createUI
{
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreen_Size.width, 200)];
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 210, 50, 50)];
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 210, 150, 50)];
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:17];
    _nameLabel.font = [UIFont boldSystemFontOfSize:17];
    _nameLabel.textAlignment = 0;
    _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(205, 215, 150, 35)];
    _typeLabel.textColor = [UIColor blackColor];
    _typeLabel.font = [UIFont boldSystemFontOfSize:15];
    _typeLabel.textAlignment = 0;
    _sayLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 250, KScreen_Size.width - 90, 40)];
    _sayLabel.textAlignment = 0;
    _sayLabel.numberOfLines = 0;
    _sayLabel.font = [UIFont systemFontOfSize:14];
    UILabel * skillLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 270, 200, 40)];
    skillLabel.textAlignment = 0;
    skillLabel.text = @"英雄技能";
    skillLabel.font = [UIFont boldSystemFontOfSize:16];
    for (int i = 0; i < 5; i ++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(40 + i * 60, 320, 50, 50)];
        //        imageView.backgroundColor = [UIColor greenColor];
        imageView.tag = 10 + i ;
        [self.tableView addSubview:imageView];
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(40 + i * 60, 360, 50, 50)];
        label.textAlignment = 1;
        label.tag = 20 + i;
        [self.tableView addSubview:label];
        
    }
    UILabel * background = [[UILabel alloc]initWithFrame:CGRectMake(10, 390, 200, 40)];
    background.text = @"背景故事";
    background.textAlignment = 0;
    background.font = [UIFont boldSystemFontOfSize:16];
    _storyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 405, KScreen_Size.width-40, 100)];
    _storyLabel.numberOfLines = 0;
    _storyLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.tableView addSubview:_headImageView];
    [self.tableView addSubview:_storyLabel];
    [self.tableView addSubview:background];
    [self.tableView addSubview:skillLabel];
    [self.tableView addSubview:_nameLabel];
    [self.tableView addSubview:_typeLabel];
    [self.tableView addSubview:_sayLabel];
    [self.tableView addSubview:_topImageView];
    
}


-(void)loadData
{
    [self loadDataWithPath:[NSString stringWithFormat:StatusUrl,self.link]];
}
-(void)paseData:(id)data
{
    _dict = [NSMutableDictionary dictionary];
    NSDictionary * result = data[@"result"];
    [_dict addEntriesFromDictionary:result];
    NSLog(@"%@",_dict[@"title"]);
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:_dict[@"img_top"]]];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_dict[@"img"]]];
    NSLog(@"%@",_dict[@"img_top"]);
    _nameLabel.text = _dict[@"title"];
    _typeLabel.text = _dict[@"tags"];
    _sayLabel.text = _dict[@"say"];
    _storyLabel.text = _dict[@"background"];
     self.title = _dict[@"title"];
    _storyLabel.font = [UIFont systemFontOfSize:15];
    NSDictionary * des = @{NSFontAttributeName:_storyLabel.font};
    CGSize maxSize = CGSizeMake(KScreen_Size.width-40, CGFLOAT_MAX);
    CGSize desc = [_dict[@"background"] boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:des context:nil].size;
   
    _storyLabel.frame = CGRectMake(20, 420, KScreen_Size.width-40, desc.height);
    

    NSArray * array = _dict[@"skill"];
    for (int i=0; i<array.count; i++) {
        NSDictionary * dic = array[i];
        
        UIImageView * imageview = (id)[self.view viewWithTag:10 + i];
        UILabel * label = (id)[self.view viewWithTag:20 + i];
        [imageview sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]]];
        label.text = dic[@"key"];

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
