//
//  AppDelegate.h
//  Seven微博
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "common.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) SinaWeibo *sinaWeibo;


@end


