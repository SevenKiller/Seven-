//
//  WeiboAnnotationView.h
//  Seven微博
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
@interface WeiboAnnotationView : MKAnnotationView {
    UIImageView *_headerImageView;
    UILabel *_textLabel;
}

@end
