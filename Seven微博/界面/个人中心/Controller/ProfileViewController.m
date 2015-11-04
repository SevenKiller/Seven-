//
//  ProfileViewController.m
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "WeiboCell.h"
#import "SDImageCache.h"
#import "personalViewController.h";
@interface ProfileViewController ()

@end

@implementation ProfileViewController

/*
 //登出测试
 - (IBAction)testLogout:(id)sender {
 AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
 SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
 [sinaWeibo logOut];
 }



 - (IBAction)testGetWeibo:(id)sender {
 
 AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
 SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
 [sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                    params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
                httpMethod:@"GET"
                  delegate:self];
 }
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createTableView];
    // Do any additional setup after loading the view.
}
- (void)_createTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    //创建头视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    view.backgroundColor = [UIColor redColor];
    _tableView.tableHeaderView = view;

    _headerImageView = [[ThemeImageView alloc] initWithFrame:CGRectMake(10, 10, 70, 70)];
    _headerImageView.layer.cornerRadius = 35;
    _headerImageView.backgroundColor = [UIColor blueColor];
    [_tableView.tableHeaderView addSubview:_headerImageView];

    _nicknameLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(90, 10, kScreenWidth - 100, 21)];
    _nicknameLabel.backgroundColor = [UIColor blueColor];
    [_tableView.tableHeaderView addSubview:_nicknameLabel];

    _messageLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(90, 35, kScreenWidth - 100, 21)];
    _messageLabel.backgroundColor = [UIColor blueColor];
    [_tableView.tableHeaderView addSubview:_messageLabel];

    _signatureLabel = [[ThemeLabel alloc] initWithFrame:CGRectMake(90, 60, kScreenWidth - 100, 21)];
    _signatureLabel.backgroundColor = [UIColor blueColor];
    [_tableView.tableHeaderView addSubview:_signatureLabel];
    CGFloat width = kScreenWidth / 5;
    for (int i = 0; i < 5; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width + 8, 90, 60, 60);
        button.backgroundColor = [UIColor blueColor];
        button.layer.cornerRadius = 10;
        button.layer.borderWidth = 3;
        button.layer.borderColor = [UIColor blackColor].CGColor;
        [_tableView.tableHeaderView addSubview:button];
    }
    
    UIButton *maskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    maskBtn.frame = _tableView.tableHeaderView.bounds;
    [_tableView.tableHeaderView addSubview:maskBtn];
    
    [maskBtn addTarget:self action:@selector(maskBtnAction:) forControlEvents:UIControlEventTouchUpInside];


}

- (void)maskBtnAction:(UIButton *)btn {
    [self.navigationController pushViewController:[[personalViewController alloc] init] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

        return 40;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
