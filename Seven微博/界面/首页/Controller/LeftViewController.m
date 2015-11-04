//
//  LeftViewController.m
//  WeiBo
//
//  Created by mac on 15/10/10.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "LeftViewController.h"
#import "ThemeLabel.h"
@interface LeftViewController (){
    
    UITableView *_leftTableView;
    
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createTableView];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self _loadImage];
    [_leftTableView reloadData];
}
- (void)_createTableView {
    _leftTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_leftTableView];
    
}
#pragma mark - UITableViewDataSource Delegate
//返回单元格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 5;
    }
    else{
        return 2;
    }
    
}

//返回单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(8, 0, 120, cell.bounds.size.height)];
            label.text = @"无";
            label.colorName = @"More_Item_Text_color";
            [cell.contentView addSubview:label];
        }else if(indexPath.row == 1) {
            ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(8, 0, 120, cell.bounds.size.height)];
            label.text = @"偏移";
            label.colorName = @"More_Item_Text_color";
            
            [cell.contentView addSubview:label];
            
        }
        else if (indexPath.row == 2){
            ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(8, 0, 120, cell.bounds.size.height)];
            label.text = @"偏移&缩放";
            label.colorName = @"More_Item_Text_color";
            
            [cell.contentView addSubview:label];
        }
        else if (indexPath.row == 3){
            ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(8, 0, 120, cell.bounds.size.height)];
            label.text = @"旋转";
            label.colorName = @"More_Item_Text_color";
            
            [cell.contentView addSubview:label];
        }
        else if (indexPath.row == 4){
            ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(8, 0, 120, cell.bounds.size.height)];
            label.text = @"视差";
            label.colorName = @"More_Item_Text_color";
            
            [cell.contentView addSubview:label];
        }
    }
    else{
        
        if (indexPath.row == 0){
            ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(8, 0, cell.bounds.size.width-50, cell.bounds.size.height)];
            label.text = @"小图";
            label.colorName = @"More_Item_Text_color";
            
            [cell.contentView addSubview:label];
        }
        else if (indexPath.row == 1){
            ThemeLabel *label = [[ThemeLabel alloc] initWithFrame:CGRectMake(8, 0, cell.bounds.size.width-50, cell.bounds.size.height)];
            label.text = @"大图";
            label.colorName = @"More_Item_Text_color";
            
            [cell.contentView addSubview:label];
        }
        
    }
    
    return cell;
}

//头视图内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        ThemeLabel *label = [[ThemeLabel alloc] init];
        label.text = @"界面切换效果";
        label.font = [UIFont systemFontOfSize:23];
        label.colorName = @"More_Item_Text_color";
        
        return label;
    }else if (section == 1){
        
        ThemeLabel *label = [[ThemeLabel alloc] init];
        label.text = @"图片浏览模式";
        label.font = [UIFont systemFontOfSize:23];
        label.colorName = @"More_Item_Text_color";
        
        return label;
    }
    return nil;
    
}

//头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 80;
    }else{
        
        return 46;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}

//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 42;
}

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
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
