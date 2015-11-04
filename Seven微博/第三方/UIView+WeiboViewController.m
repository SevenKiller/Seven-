//
//  UIView+WeiboViewController.m
//  Seven微博
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UIView+WeiboViewController.h"

@implementation UIView (WeiboViewController)
- (UIViewController *)viewController {
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = next.nextResponder;
    }
    return nil; 
}
@end
