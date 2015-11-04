//
//  CommentTableView.h
//  Seven微博
//
//  Created by mac on 15/10/17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserView.h"
#import "WeiboView.h"
#import "WeiboModel.h"
#import "CommentCell.h"


@interface CommentTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
{
    UserView *_userView;
    WeiboView *_weibView;
    
    //头视图
    UIView *_headerView;
}

@property (strong, nonatomic) NSArray *commentDataArray;
@property (strong, nonatomic) WeiboModel *weiboModel;
@property (strong, nonatomic) NSDictionary *commentDic;
@end
