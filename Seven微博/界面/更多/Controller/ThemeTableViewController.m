//
//  ThemeTableViewController.m
//  WeiBo
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "ThemeTableViewController.h"
#import "MoreTableViewCell.h"
#import "ThemeManager.h"

static NSString *moreCellID = @"moreCellID";

@interface ThemeTableViewController (){
    NSArray *_themeNameArray;
}

@end

@implementation ThemeTableViewController


//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
//    }
//    return  self;
//    
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
    
    NSDictionary *themeConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    
    _themeNameArray = [themeConfig allKeys];
    
    [self.tableView registerClass:[MoreTableViewCell class] forCellReuseIdentifier:moreCellID];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// Return the number of sections.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

// Return the number of rows in the section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _themeNameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellID forIndexPath:indexPath];

    cell.themeTextLabel.text = _themeNameArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *themeName = _themeNameArray[indexPath.row];
    
    [[ThemeManager shareInstance] setThemeName:themeName];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
