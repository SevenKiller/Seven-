//
//  WeiboDetaiViewController.m
//  Seven微博
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "WeiboDetaiViewController.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
@implementation WeiboDetaiViewController
{
    SinaWeiboRequest *_request;

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"微博详情";
       
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _createTableView];
    [self _loadData];

    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [_request disconnect];
}
- (void)_createTableView {
    
    _tableView = [[CommentTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.weiboModel = self.model;
    
    //上拉加载
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];

    
}
- (void)_loadData {
//    NSString *weiboId = [self.model.weiboId stringValue];
    NSString *weiboId = self.model.weiboIdStr;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:weiboId forKey:@"id"];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    _request =  [sinaWeibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    _request.tag = 100;

    
}
- (void)_loadMoreData {
    
//    NSString *weiboId = [self.model.weiboId stringValue];
    NSString *weiboId = self.model.weiboIdStr;

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:weiboId forKey:@"id"];
    
    
    //设置max_id 分页加载
    CommentModel *cm = [self.data lastObject];
    if (cm == nil) {
        return;
    }
    NSString *lastID = cm.idstr;
    [params setObject:lastID forKey:@"max_id"];
    
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    _request =  [sinaWeibo requestWithURL:comments params:params httpMethod:@"GET" delegate:self];
    _request.tag = 102;
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSLog(@"网络接口 请求成功");
    
    NSArray *array = [result objectForKey:@"comments"];
    
    NSMutableArray *comentModelArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    
    for (NSDictionary *dataDic in array) {
        CommentModel *commentModel = [[CommentModel alloc]initWithDataDic:dataDic];
        [comentModelArray addObject:commentModel];
    }
    
    
    if (request.tag == 100) {
        self.data = comentModelArray;
        
    }else if(request.tag ==102){//更多数据
        [_tableView.footer endRefreshing];
        if (comentModelArray.count > 1) {
            [comentModelArray removeObjectAtIndex:0];
            [self.data addObjectsFromArray:comentModelArray];
        }else{
            return;
        }
    }
    
    _tableView.commentDataArray = self.data;
    _tableView.commentDic = result;
    [_tableView reloadData];
    
    
    
}
@end
