//
//  MoreViewController.m
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "MoreViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeTableViewController.h"
#import "AppDelegate.h"

static NSString *moreCellID = @"moreCellID";

@interface MoreViewController (){
    UITableView *_tableView;
}

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createTableView];
    
}

//每次出现的时候重新刷新数据
- (void)viewWillAppear:(BOOL)animated{
    
    [_tableView reloadData];
}

- (void)_createTableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    //注册
    [_tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:moreCellID];
}

#pragma mark - UITableViewDataSource
//返回单元格每组个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
    
}

//返回单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellID forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            cell.themeImageView.imageName = @"more_icon_theme.png";
            cell.themeTextLabel.text = @"主题选择";
            cell.themeDetailLabel.text = [ThemeManager shareInstance].themeName;
        }
        else{
            cell.themeImageView.imageName = @"more_icon_account.png";
            cell.themeTextLabel.text = @"账户管理";
        }
    }
    else if(indexPath.section == 1){
        cell.themeTextLabel.text = @"意见反馈";
        cell.themeImageView.imageName = @"more_icon_feedback.png";
    }
    else if (indexPath.section == 2){
        cell.themeTextLabel.text = @"登出当前账号";
        cell.themeTextLabel.textAlignment = NSTextAlignmentCenter;
        
        cell.themeTextLabel.center = cell.contentView.center;
    }
    
    
    //设置箭头
    if (indexPath.section != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

//返回单元格组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

//单元格选中事件-->选择主题
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //进入主题选择页面
    if (indexPath.section == 0 && indexPath.row == 0) {
        ThemeTableViewController *ThemeTVC = [[ThemeTableViewController alloc] init];
        
        [self.navigationController pushViewController:ThemeTVC animated:YES];
    }
    
    //登出
    if (indexPath.section == 2 && indexPath.row == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登出当前账号" message:nil delegate:self
    cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
        [sinaWeibo logOut];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
