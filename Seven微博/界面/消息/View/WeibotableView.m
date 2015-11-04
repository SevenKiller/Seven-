//
//  WeibotableView.m
//  Seven微博
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "WeibotableView.h"
#import "WeiboViewFrameLayout.h"
#import "WeiboCell.h"
#import "WeiboViewFrameLayout.h"
#import "UIView+WeiboViewController.h"
#import "WeiboDetaiViewController.h"
@implementation WeibotableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
       
        self.delegate = self;
        self.dataSource = self;
        
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"WeiboCell" bundle:nil];
        [self registerNib:nib forCellReuseIdentifier:@"WeiboCell"];
    
        
    }
    return self;
}

#pragma mark - 代理数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeiboViewFrameLayout *layout =  _data[indexPath.row];
    return layout.frame.size.height + 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WeiboCell *cell = (WeiboCell *) [tableView dequeueReusableCellWithIdentifier:@"WeiboCell" forIndexPath:indexPath];
    WeiboViewFrameLayout *layout = _data[indexPath.row];
    cell.layout = layout;
    cell.selectionStyle = UITableViewScrollPositionNone;
    return cell;

}
#pragma mark - 单元格选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    WeiboDetaiViewController *weiboVC = [[WeiboDetaiViewController alloc] init];
    WeiboViewFrameLayout *layout = _data[indexPath.row];
    WeiboModel *model = layout.model;
    weiboVC.model = model;
    [self.viewController.navigationController pushViewController:weiboVC animated:YES];
    
    
}

@end
