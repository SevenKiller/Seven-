//
//  LocViewController.h
//  Seven微博
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "PoiModel.h"

@interface LocViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
    
    UITableView *_tableView;
    CLLocationManager *_locationManager;
}

//存放服务器返回的地理信息
@property (nonatomic ,strong) NSArray *dataList;
@end
