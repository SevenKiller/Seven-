//
//  SendViewController.m
//  Seven微博
//
//  Created by mac on 15/10/19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SendViewController.h"
#import "ThemeManager.h"
#import "ThemeButton.h"
#import "MMDrawerBarButtonItem.h"
#import "DataService.h"
@implementation SendViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        //发送通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发送微博";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self _createEditView];
    [self _createItemButton];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    //弹出键盘,textView成为第一响应者
    [_textView becomeFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
//    //导航栏不透明
//    self.navigationController.navigationBar.translucent = NO;
//    _textView.frame = CGRectMake(0, 0, kScreenWidth, 120);
//    [_textView becomeFirstResponder];
    
}

#pragma mark - 创建发送关闭按钮
- (void)_createItemButton {
    //关闭按钮
    ThemeButton *closeBtn = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    closeBtn.normalImageName = @"button_icon_close.png";
    
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    [self.navigationItem setLeftBarButtonItem:closeItem];
    
    //发送按钮
    ThemeButton *sendBtn = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendBtn.normalImageName = @"button_icon_ok.png";
    
    [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendBtn];
    [self.navigationItem setRightBarButtonItem:sendItem];
    
   
    
}
#pragma mark - 关闭窗口
- (void)closeAction {
    [_textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 发送微博
- (void)sendAction {
    NSString *text = _textView.text;
    NSString *error = nil;
    if (text.length == 0) {
        error = @"发送内容为空";
    }else if (text.length > 140) {
        error = @"微博内容大于140个字符";
    }
    if (error != nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
   AFHTTPRequestOperation *operation = [DataService sendWeibo:text image:_sendImage block:^(id result) {
        NSLog(@"%@",error);
       [self showStatusTip:@"发送成功" show:NO operation:operation];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self showStatusTip:@"正在发送" show:YES operation:operation];

    
}
#pragma mark - 创建编辑框
- (void)_createEditView {
    
    //编辑框
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    _textView.font = [UIFont systemFontOfSize:16];
    _textView.backgroundColor = [UIColor clearColor];
    _textView.editable = YES;
    _textView.layer.cornerRadius = 10;
    _textView.layer.borderWidth = 2;
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:_textView];
    
    //编辑工具栏
    _editorBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 55)];
    _editorBar.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_editorBar];
    
    //创建多个编辑按钮
    NSArray *editorImages =  @[
                            @"compose_toolbar_1.png",
                            @"compose_toolbar_4.png",
                            @"compose_toolbar_3.png",
                            @"compose_toolbar_5.png",
                            @"compose_toolbar_6.png"
                            ];
    for (int i = 0; i <editorImages.count; i ++) {
        NSString *imageName = editorImages[i];
        ThemeButton *editorBtn = [[ThemeButton alloc] initWithFrame:CGRectMake(15+(kScreenWidth/5)*i, 20, 40, 33)];
        [editorBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        editorBtn.normalImageName = imageName;
        editorBtn.tag = i;
        [_editorBar addSubview:editorBtn];
        
    }
    
    //创建label 显示位置信息
    _locLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -30, kScreenWidth, 30)];
    _locLabel.hidden = YES;
    _locLabel.font = [UIFont systemFontOfSize:14];
    _locLabel.backgroundColor = [UIColor grayColor];
    [_editorBar addSubview:_locLabel];
    
    
}
- (void)buttonAction:(UIButton *)btn {
    if (btn.tag == 0) {
        [self _selectPhoto];
        
    }else if (btn.tag == 2) {
        [self _location];
        
    }
    
}

#pragma mark - 定位
- (void)_location {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        
        if (kVersion > 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
        
    }
    //设置定位精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];

    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations{
//    NSLog(@"已经更新位置");
    [_locationManager stopUpdatingLocation];
    
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"经度 %lf 纬度 %lf",coordinate.longitude,coordinate.latitude);
    
    //地理位置反编码
    //一 新浪位置反编码 接口说明  http://open.weibo.com/wiki/2/location/geo/geo_to_address
    
    NSString *coordinateStr = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:coordinateStr forKey:@"coordinate"];
    
    
    __weak __typeof(self) weakSelf = self;
    [DataService requestAFUrl:geo_to_address httpMethod:@"GET" params:params data:nil block:^(id result) {
        NSArray *geos = [result objectForKey:@"geos"];
        if (geos.count > 0) {
            NSDictionary *geoDic = [geos lastObject];
            
            NSString *addr = [geoDic objectForKey:@"address"];
            NSLog(@"地址 %@",addr);
            // weakSelf->_locLabel.text = ...
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                __strong __typeof(self) strongSelf = weakSelf;
                strongSelf->_locLabel.text = addr;
                strongSelf->_locLabel.hidden = NO;
            });
            
        }
        
    }];

    
    
    //iOS内置
    /*
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *place = [placemarks lastObject];
        NSLog(@"位置:%@",place.name);
    }];
     */

}


#pragma mark - 选择照片
- (void)_selectPhoto {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
    [sheet showInView:self.view];
    
}
#pragma mark - 键盘弹出通知
- (void)keyBoardWillShow:(NSNotification *)notification {
    NSValue *boundleValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [boundleValue CGRectValue];
    CGFloat height = frame.size.height;
    _editorBar.bottom = kScreenHeight - height - 64;
}

#pragma mark - 相机相册选择代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamere = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamere) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"摄像头无法使用" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            
            return;

        }
    } else if (buttonIndex == 1) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}
//照片选择代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //弹出相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    //2 取出照片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //3 显示缩略图
    
    if (_zoomImageView == nil) {
        _zoomImageView = [[ZoomImageView alloc] init];
        // _zoomImageView = [[ZoomImageView alloc] initWithImage:image];
        _zoomImageView.frame = CGRectMake(10, _textView.bottom+10, 80, 80);
        [self.view addSubview:_zoomImageView];
        
    }
    _zoomImageView.image = image;
    _sendImage = image;
    _zoomImageView.delegate = self;
    
}
- (void)imageWillZoomIn:(ZoomImageView *)imageView {
    [_textView resignFirstResponder];
}
- (void)imageWillZoomOut:(ZoomImageView *)imageView {
    [_textView becomeFirstResponder];
}
@end
