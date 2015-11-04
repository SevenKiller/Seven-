//
//  WeiboAnnotation.m
//  Seven微博
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "WeiboAnnotation.h"

@implementation WeiboAnnotation

- (void)setModel:(WeiboModel *)model {
    if (_model != model) {
        _model = model;
        
        NSDictionary *geo = model.geo;
        NSArray *coodinates = [geo objectForKey:@"coordinates"];
        
        if (coodinates.count > 0) {
            NSString *longitude = coodinates[0];
            NSString *latitude = coodinates[1];
            self.coordinate = CLLocationCoordinate2DMake([longitude floatValue], [latitude floatValue]);
        }
    }
}
@end
