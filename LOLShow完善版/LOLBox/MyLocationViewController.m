//
//  MyLocationViewController.m
//  LOLBox
//
//  Created by qianfeng on 15/12/22.
//  Copyright (c) 2015年 caopengfei. All rights reserved.
//

#import "MyLocationViewController.h"
#import  <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MyLocationViewController ()<MAMapViewDelegate,CLLocationManagerDelegate>
{
    MAMapView * _mapView;
    CLLocationManager * _location;
}
@end

@implementation MyLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的位置";
    [self openLocation];
    [self addUI];
    
}
-(void)addUI
{
    
    [MAMapServices sharedServices].apiKey = @"cf4478c96f5de127d3db9e8fa26b1518";
    _mapView = [[MAMapView alloc]initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = 1;
    [self.view addSubview:_mapView];

}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
-(void)openLocation
{
    _location = [[CLLocationManager alloc]init];
    
    //接受代理
    _location.delegate = self;
    
    //2、询问用户开启定位
    //判断设备具不具备定位功能
    if ([CLLocationManager locationServicesEnabled] == YES) {
        //程序要一直使用你的定位
        //[_location requestAlwaysAuthorization];
        //只在程序运行期间获取定位
        [_location requestWhenInUseAuthorization];
    }
    
    //3、可以设置定位的精度
    //根据需要设置精度，进度越精确耗电越厉害
    _location.desiredAccuracy = 50;
    
    //4、设置更新定位信息的精度
    _location.distanceFilter = 100;

}
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}
//-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    if ([_location respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        NSString *message = @"您的手机目前未开启定位服务，如欲开启定位服务，请至设定开启定位服务功能";
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"无法定位" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//    }else
//    {
//       
//            
//            [_location startUpdatingLocation];
//        
//    }
//}



@end
