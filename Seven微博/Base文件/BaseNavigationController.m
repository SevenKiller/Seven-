//
//  BaseNavigationController.m
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "BaseNavigationController.h"
#import "ThemeManager.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

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
    
    //01 设置导航栏背景图片
    ThemeManager *manager = [ThemeManager shareInstance];
    UIImage *image = [manager getThemeImage:@"mask_titlebar64.png"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //02 标题颜色
    // Mask_Title_color
    UIColor *color  = [manager getThemeColor:@"Mask_Title_color"];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadImage];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
