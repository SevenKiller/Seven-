//
//  BaseViewController.h
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperation.h"
@interface BaseViewController : UIViewController
- (void)setNavItem;
- (void)_loadImage;

- (void)showHud:(NSString *)title;
- (void)completeHud:(NSString *)title;
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation;
@end
