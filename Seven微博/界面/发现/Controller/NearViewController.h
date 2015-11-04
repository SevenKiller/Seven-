//
//  NearViewController.h
//  Seven微博
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface NearViewController : BaseViewController<CLLocationManagerDelegate,MKMapViewDelegate>

@end
