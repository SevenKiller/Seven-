//
//  SendViewController.h
//  Seven微博
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "ZoomImageView.h"
#import <CoreLocation/CoreLocation.h>

@interface SendViewController : BaseViewController<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,ZoomImageViewDelegate,CLLocationManagerDelegate>{
    
    //文本编辑
    UITextView *_textView;
    
    //发送图片
    UIImage *_sendImage;
    
    //编辑工具
    UIView *_editorBar;
    
    //缩略图
    ZoomImageView *_zoomImageView;
    
    //位置管理
    CLLocationManager *_locationManager;
    UILabel *_locLabel;
}

@end
