//
//  DiscoverViewController.m
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "DiscoverViewController.h"
#import "AppDelegate.h"
#import "NearViewController.h"
@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
//登陆测试
- (IBAction)loginAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
    if ([sinaWeibo isLoggedIn]) {
        NSLog(@"已经登陆");
    }else{
        [sinaWeibo logIn];
    }
    
}
- (IBAction)nearWeiBo:(UIButton *)sender {
    [self.navigationController pushViewController:[[NearViewController alloc] init] animated:YES];
}
- (IBAction)nearPerson:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
