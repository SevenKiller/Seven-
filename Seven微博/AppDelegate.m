//
//  AppDelegate.m
//  Seven微博
//
//  Created by mac on 15/10/11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //左边控制器
    UIViewController * leftSideDrawerViewController = [[LeftViewController alloc] init];
    //leftSideDrawerViewController.view.backgroundColor = [UIColor redColor];
    //中间控制器
    MainTabBarController *mainTabVc = [[MainTabBarController alloc] init];
    //右边控制器
    UIViewController * rightSideDrawerViewController = [[RightViewController alloc] init];
    //rightSideDrawerViewController.view.backgroundColor = [UIColor greenColor];
    
    //容器控制器，管理左 中 右控制器
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:mainTabVc
                                             leftDrawerViewController:leftSideDrawerViewController
                                             rightDrawerViewController:rightSideDrawerViewController];
    
    
    //设置左右两边宽度
    [drawerController setMaximumRightDrawerWidth:60];
    [drawerController setMaximumLeftDrawerWidth:150];
    
    //设置手势区域
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    //设置动画效果
    MMDrawerControllerDrawerVisualStateBlock block = [MMDrawerVisualState swingingDoorVisualStateBlock];
    [drawerController setDrawerVisualStateBlock:block];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = drawerController;
    
    
    //------------------微博SDK ------------
    
    self.sinaWeibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
   
    [self readAuthData];
//    NSLog(NSHomeDirectory());
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SevenSinaWeiboAuthData"];
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = self.sinaWeibo;
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SevenSinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)readAuthData{
    //读取
    SinaWeibo *sinaweibo = self.sinaWeibo;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SevenSinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
}

//登陆成功
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo{
    NSLog(@"登陆成功");
    NSLog(@"%@,%@,%@",self.sinaWeibo.accessToken,self.sinaWeibo.userID,self.sinaWeibo.expirationDate);
    
    [self storeAuthData];
    
}
//登出成功
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo{
    [self removeAuthData];
}
//登陆取消
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo{
    
}
//登陆失败
- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error{
    
}


//令牌过期
- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error{
    
}

//SSO 授权回调处理
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self.sinaWeibo handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self.sinaWeibo handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [self.sinaWeibo applicationDidBecomeActive];
}
@end
