//
//  BaseViewController.m
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "BaseViewController.h"
#import "ThemeManager.h"
#import "MMDrawerController.h"
#import "AppDelegate.h"
#import "UIViewController+MMDrawerController.h"
#import "UIProgressView+AFNetworking.h"
#import "ThemeButton.h"
#import "MBProgressHUD.h"
//#import "AFHTTPRequestOperation.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
{
    MBProgressHUD *_hud;
    UIWindow *_tiWindow;
}
- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"initWithCoder");
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
        
    }
    return self;
    
}

- (void)themeDidChange:(NSNotification *)notification{
    [self _loadImage];
}

- (void)_loadImage{
    ThemeManager *manager = [ThemeManager shareInstance];
    //01 设置背景图片
    UIImage *bgImage = [manager getThemeImage:@"bg_home.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}

- (void)setNavItem{
    ThemeButton *left = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    left.bgNormalImageName = @"button_title";
    left.normalImageName = @"group_btn_all_on_title";
    [left setTitle:@"设置" forState:UIControlStateNormal];
    [left addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    //转换成UIBarButtonItem
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    ThemeButton *right = [[ThemeButton alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    right.bgNormalImageName = @"button_title";
    right.normalImageName = @"group_btn_all_on_title";
    [right setTitle:@"编辑" forState:UIControlStateNormal];
    [right addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    //转换成UIBarButtonItem
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:right];

    self.navigationItem.rightBarButtonItem = rightItem;
}


- (void)setAction{

    
    //02 方法二
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}


- (void)editAction{
    MMDrawerController *mmDraw = self.mm_drawerController;
    [mmDraw openDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setNavItem];
    [self _loadImage];
  
}
#pragma mark - 进度条
- (void)showHud:(NSString *)title {
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [_hud show:YES];
    _hud.labelText = title;
    _hud.dimBackground = YES;
}


- (void)completeHud:(NSString *)title {
    _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    _hud.mode = MBProgressHUDModeCustomView;
    _hud.labelText = title;
    [_hud hide:YES afterDelay:1.5];
}

#pragma mark - 发送状态显示
- (void)showStatusTip:(NSString *)title
                 show:(BOOL)show
            operation:(AFHTTPRequestOperation *)operation {
    if (_tiWindow == nil) {
        _tiWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        _tiWindow.backgroundColor = [UIColor whiteColor];
        _tiWindow.windowLevel = UIWindowLevelStatusBar;
        
        UILabel *label = [[UILabel alloc] initWithFrame:_tiWindow.bounds];
        label.font = [UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 100;
        [_tiWindow addSubview:label];
        
        //进度条
        UIProgressView *progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 17, kScreenWidth, 5)];
        progress.tag = 101;
        progress.progress = 0.0;
        [_tiWindow addSubview:progress];
        
    }
    UILabel *label = (UILabel *)[_tiWindow viewWithTag:100];
    label.text = title;
    UIProgressView *progress = (UIProgressView *)[_tiWindow viewWithTag:101];
    
    if (show) {
        [_tiWindow setHidden:NO];
        if (operation != nil) {
            progress.hidden = NO;
            [progress setProgressWithUploadProgressOfOperation:operation animated:YES];
        }else {
            progress.hidden = YES;
        }
    }else {
        [self performSelector:@selector(showTip) withObject:nil afterDelay:0.5];
    }
    
  
}
- (void)showTip {
    [_tiWindow setHidden:YES];
    _tiWindow = nil;
    
}
@end
