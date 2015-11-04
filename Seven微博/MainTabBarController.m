//
//  MainTabBarController.m
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "common.h"
#import "ThemeImageView.h" 
#import "ThemeButton.h"
#import "AppDelegate.h"
#import "ThemeLabel.h"
@interface MainTabBarController ()
{
    ThemeImageView *_selectedImageView;
    ThemeImageView *_badgeImageView;
    ThemeLabel *_badgeLabel;

}

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建子视图控制器
    [self _createSubController];
    
    //设置 tabbar
    [self _createTabBar];
    
    [NSTimer scheduledTimerWithTimeInterval:1000 target:self selector:@selector(timeAction:) userInfo:nil repeats:YES];
}
- (void)timeAction:(NSTimer *)time {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
    [sinaWeibo requestWithURL:unread_count params:nil httpMethod:@"GET" delegate:self];
    
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result{
    NSNumber *status = [result objectForKey:@"status"];
    NSInteger count = [status integerValue];
    CGFloat buttonWidth = kScreenWidth / 4;
    if (_badgeImageView == nil) {
        _badgeImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(buttonWidth-32, 0, 42, 32)];
        _badgeImageView.imageName = @"number_notify_9.png";
        
        [self.tabBar addSubview:_badgeImageView];
        _badgeLabel = [[ThemeLabel alloc] initWithFrame:_badgeImageView.bounds];
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.colorName = @"Timeline_Notice_color";
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.font = [UIFont systemFontOfSize:13];
        [_badgeImageView addSubview:_badgeLabel];
        
    }
    if (count == 0) {
        _badgeImageView.hidden = YES;
    }else if(count > 99){
        _badgeImageView.hidden = NO;
        _badgeLabel.text = @"99+";
        
    }else{
        _badgeImageView.hidden = NO;
        _badgeLabel.text = [NSString stringWithFormat:@"%li",count];
        
    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)_createTabBar{
    //1.移除TabBarButton
    for (UIView *view in self.tabBar.subviews) {
        //通过字符串获得类对象
        Class cls = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:cls]) {
            [view removeFromSuperview];
        }
    }
    
    //2.背景图
    ThemeImageView *bgImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    bgImageView.imageName = @"mask_navbar.png";
    
    [self.tabBar addSubview:bgImageView];
    
    //3.选中图片
 
    _selectedImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/4, 49)];
    _selectedImageView.imageName = @"home_bottom_tab_arrow.png";
    [self.tabBar addSubview:_selectedImageView];
    
    //4.设置按钮
//    NSArray *imageNames = @[@"Skins/cat/home_tab_icon_1.png",
//                            @"Skins/cat/home_tab_icon_2.png",
//                            @"Skins/cat/home_tab_icon_3.png",
//                            @"Skins/cat/home_tab_icon_4.png",
//                            @"Skins/cat/home_tab_icon_5.png"];
    
//    NSArray *imageNames = @[@"home_tab_icon_1.png",
//                            @"home_tab_icon_2.png",
//                            @"home_tab_icon_3.png",
//                            @"home_tab_icon_4.png",
//                            @"home_tab_icon_5.png"];
    NSArray *imageNames = @[@"home_tab_icon_1.png",
                            @"home_tab_icon_2.png",
                            @"home_tab_icon_3.png",
                            @"home_tab_icon_4.png"];

    


    
    CGFloat width = kScreenWidth / 4;
    
    for (int i = 0; i < imageNames.count; i++) {
        ThemeButton *button = [[ThemeButton alloc] initWithFrame:CGRectMake(i * width, 0, width, 49)];
        button.normalImageName = imageNames[i];
        
        button.tag = i + 1;
        
        [button addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
        
    }
    
}

- (void)selectedAction:(UIButton *)button{
    [UIView animateWithDuration:0.3 animations:^{
        _selectedImageView.center = button.center;
    }];
    
    self.selectedIndex = button.tag - 1;
    
}

- (void)_createSubController{
    
    NSArray *storyNames = @[@"Home",@"Discover",@"Profile",@"More"];
    NSMutableArray *navArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    for (int i = 0; i < storyNames.count; i++) {
        //创建storyBoard对象
        UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:storyNames[i] bundle:nil];
        
        //通过 storyBoard创建控制器对象
        BaseNavigationController *navVC = [storyBorad instantiateInitialViewController];
        
        [navArray addObject:navVC];
    }
    self.viewControllers = navArray;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
