//
//  WeiboDetaiViewController.h
//  Seven微博
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "WeiboModel.h"
#import "CommentTableView.h"
#import "SinaWeibo.h"
@interface WeiboDetaiViewController : BaseViewController<SinaWeiboRequestDelegate>
@property (nonatomic,strong)CommentTableView *tableView;
@property (nonatomic, strong) WeiboModel *model;
//评论数据表
@property (nonatomic, assign) NSMutableArray *data;
@end
