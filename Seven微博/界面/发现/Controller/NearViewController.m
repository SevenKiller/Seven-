//
//  NearViewController.m
//  Seven微博
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NearViewController.h"
#import "WeiboAnnotation.h"
#import "WeiboAnnotationView.h"
#import "common.h"
#import "WeiboDetaiViewController.h"
#import "DataService.h"
@interface NearViewController ()

@end
@implementation NearViewController {
    CLLocationManager *_locationManager;
    MKMapView *_mapView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createView];
    
//    CLLocationCoordinate2D coordinate = {30.2042,120.2019};
//    WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
//    annotation.coordinate = coordinate;
//   
//    annotation.title = @"初代七杀";
//    annotation.subtitle = @"Seven";
//    [_mapView addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)_createView {
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    //现实用户位置
    _mapView.showsUserLocation = YES;
    //卫星地图
    _mapView.mapType = MKMapTypeStandard;
    //用户跟踪模式
//    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
}
#pragma mark - mapView 代理
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    NSLog(@"选中");
    if (![view.annotation isKindOfClass:[WeiboAnnotation class]]) {
        return;
    }
    
    
    WeiboAnnotation *weiboAnnotation = (WeiboAnnotation *)view.annotation;
    WeiboModel *weiboModel = weiboAnnotation.model;
    
    WeiboDetaiViewController *vc = [[WeiboDetaiViewController alloc] init];
    vc.model  = weiboModel;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -地图代理 
//http://open.weibo.com/wiki/2/place/nearby_timeline  附近动态（微博）
//位置更新后被调用
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    CLLocation *location = userLocation.location;
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"经度 %lf 纬度 %lf",coordinate.longitude,coordinate.latitude);
    
    //设置地图显示的区域
    CLLocationCoordinate2D  center = coordinate;
    MKCoordinateSpan span = {0.1,0.1};
    MKCoordinateRegion regin = {center,span};
    _mapView.region = regin;
    
    //网络获取附近微博
    NSString *lon = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSString *lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    [self _loadNearByData:lon lat:lat];
}
/*
#pragma mark - 标注视图获取
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //处理用户当前位置
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
        pin.pinColor = MKPinAnnotationColorRed;
        pin.animatesDrop = YES;
        pin.canShowCallout = YES;
        pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    }
    
    return pin;
}
 */
#pragma mark - 自定义图标视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
//处理用户当前位置
if ([annotation isKindOfClass:[MKUserLocation class]]) {
    return  nil;
}
//微博annotation，复用池
if ([annotation isKindOfClass:[WeiboAnnotation class]]) {
    WeiboAnnotationView *view = (WeiboAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"view"];
    if (view == nil) {
        view = [[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"view"];
    }
    view.annotation = annotation;
    [view setNeedsLayout];
    return view;
}

return nil;
}

//获取附近微博
- (void)_loadNearByData:(NSString *)lon lat:(NSString *)lat{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:lon forKey:@"long"];
    [params setObject:lat forKey:@"lat"];
    
    [DataService requestAFUrl:nearby_timeline httpMethod:@"GET" params:params data:nil block:^(id result) {
        
        NSArray *statuses = [result objectForKey:@"statuses"];
        NSMutableArray *annotationArray = [[ NSMutableArray alloc] initWithCapacity:statuses.count];
        
        for (NSDictionary *dic  in statuses) {
            WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dic];
            
            WeiboAnnotation *annotation = [[WeiboAnnotation alloc] init];
            annotation.model = model;
            [annotationArray addObject:annotation];
        }
        [_mapView addAnnotations:annotationArray];
        
    }];
}
@end
