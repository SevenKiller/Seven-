//
//  ZoomImageView.h
//  Seven微博
//
//  Created by mac on 15/10/17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZoomImageView;

@protocol ZoomImageViewDelegate <NSObject>

//图片将要放大
- (void)imageWillZoomIn:(ZoomImageView *)imageView;

- (void)imageWillZoomOut:(ZoomImageView *)imageView;

@end

@interface ZoomImageView : UIImageView<NSURLConnectionDataDelegate,UIAlertViewDelegate>
{
    
    UIScrollView *_scrollView;
    UIImageView *_fullImageView;
}
@property (nonatomic, weak)id<ZoomImageViewDelegate>delegate;
@property (nonatomic, copy) NSString *fullImgUrlStr;
@property (nonatomic, assign) BOOL isGif;
@property (nonatomic, strong) UIImageView *iconView;
@end
