//
//  CommentTableView.m
//  Seven微博
//
//  Created by mac on 15/10/17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CommentTableView.h"
#import "WeiboViewFrameLayout.h"

@implementation CommentTableView
static NSString *cellId = @"cellId";
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _createHeaderView];
        self.delegate = self;
        self.dataSource = self;
        UINib *nib = [UINib nibWithNibName:@"CommentCell" bundle:[NSBundle mainBundle]];
        
        [self registerNib:nib forCellReuseIdentifier:cellId];
        
    }
    
    return self;
    
}
#pragma mark - 创建头视图
- (void)_createHeaderView {
    //创建头视图
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
    _headerView.backgroundColor = [UIColor clearColor];
    
    //加载nib视图
    _userView = [[[NSBundle mainBundle] loadNibNamed:@"UserView" owner:self options:nil] lastObject];
    _userView.backgroundColor = [UIColor clearColor];
    _userView.width = kScreenWidth;
    [_headerView addSubview:_userView];
    
    //创建微博视图
    _weibView = [[WeiboView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    _weibView.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [_headerView addSubview:_weibView];
}
- (void)setWeiboModel:(WeiboModel *)weiboModel {
    
    if (_weiboModel != weiboModel) {
        _weiboModel = weiboModel;
        
        //创建微博视图布局对象
        WeiboViewFrameLayout *layoutFrame = [[WeiboViewFrameLayout alloc] init];
        layoutFrame.isDetail = YES;
        layoutFrame.model = weiboModel;
        
        _weibView.layout = layoutFrame;
        _weibView.frame = layoutFrame.frame;
        _weibView.top = _userView.bottom + 5;
        
        //2.用户视图
        _userView.weiboModel = weiboModel;
        
        //3.设置头视图
        _headerView.height = _weibView.bottom;
        self.tableHeaderView = _headerView;
        
    }
}

#pragma mark - 代理
//获取组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //创建组视图
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 40)];
    
    //评论视图
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 2, 100, 20)];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.font = [UIFont systemFontOfSize:16];
    countLabel.textColor =  [UIColor blackColor];
    //评论数量
    NSNumber *total = [self.commentDic objectForKey:@"total_number"];
    int value = [total intValue];
    countLabel.text = [NSString stringWithFormat:@"评论:%d",value];
    [sectionHeaderView addSubview:countLabel];
    
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentModel *model = self.commentDataArray[indexPath.row];
    
    //计算单元格高度
    CGFloat height = [CommentCell getCommentHeight:model];
    return height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.commentModel = self.commentDataArray[indexPath.row];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.commentDataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}


@end
