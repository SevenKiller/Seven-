//
//  personalViewController.m
//  Seven微博
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "personalViewController.h"
#import "AppDelegate.h"
#import "ThemeLabel.h"
#import "WeibotableView.h"
#import "WeiboModel.h"
#import "SinaWeibo.h"
#import "WeiboViewFrameLayout.h"
#import "ThemeButton.h"
#import "MJRefresh.h"
#import "ThemeImageView.h"
#import <AudioToolbox/AudioToolbox.h>
@implementation personalViewController
{
    NSMutableArray *_data;
    ThemeImageView *_barIamgeView;
    ThemeLabel *_barLabel;

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self _createTableView];
    [self _loadData];
    }


- (void)_createTableView {
    
    _weiboTableview = [[WeibotableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    
    _weiboTableview.backgroundColor = [UIColor clearColor];
    _weiboTableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
    _weiboTableview.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(_loadMoreData)];
    
    [self.view addSubview:_weiboTableview];
    
}
- (void)_loadData {
    /*
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
    //如果已经登陆则获取微博数据
    if (sinaWeibo.isLoggedIn) {
        [self showHud:@"正在加载..."];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:@"10" forKey:@"count"];
        
        SinaWeiboRequest *request =  [appDelegate.sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                                                                    params:params
                                                                httpMethod:@"GET"
                                                                  delegate:self];
        request.tag = 100;
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请登录" message:nil delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alert show];
    }
    [appDelegate.sinaWeibo logIn];
    
    */
    /*
     //测试 获取微博
     
     [self showHud:@"正在加载..."];
     //[self showLoading:YES];
     
     AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
     SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
     
     NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
     [params setObject:@"10" forKey:@"count"];
     
     SinaWeiboRequest * request =     [sinaWeibo requestWithURL:@"statuses/home_timeline.json"
     params:params
     httpMethod:@"GET"
     delegate:self];
     
     request.tag = 100;
     */
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
        SinaWeiboRequest *request =[sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                           params:[NSMutableDictionary dictionaryWithObject:sinaWeibo.userID forKey:@"uid"]
                       httpMethod:@"GET"
                         delegate:self];
    request.tag = 100;
    
    [_weiboTableview reloadData];

}
//加载最新数据
- (void)_loadNewData {
    
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"10" forKey:@"count"];
    
    //设置sinceId
    if (_data.count > 0) {
        WeiboViewFrameLayout *layout = [_data lastObject];
        WeiboModel *model = layout.model;
        [params setObject:model.weiboIdStr forKey:@"since_id"];
    }
    
    
    SinaWeiboRequest * request = [sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                                                    params:params
                                                httpMethod:@"GET"
                                                  delegate:self];
    
    request.tag = 101;
    
}
//加载更多数据
- (void)_loadMoreData {
    
    AppDelegate *appDelegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeibo = appDelegate.sinaWeibo;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"10" forKey:@"count"];
    
    //设置maxId
    if (_data.count > 0) {
        WeiboViewFrameLayout *layout = [_data lastObject];
        WeiboModel *model = layout.model;
        [params setObject:model.weiboIdStr forKey:@"max_id"];
    }
    
    SinaWeiboRequest *request = [sinaWeibo requestWithURL:@"statuses/user_timeline.json"
                                                   params:params
                                               httpMethod:@"GET"
                                                 delegate:self];
    request.tag = 102;
    
}

#pragma mark - SinaWeiboRequestDelegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error");
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSArray *dicArray = [result objectForKey:@"statuses"];
    
    NSMutableArray *statusesArray = [[NSMutableArray alloc] init];
    
    //解析model,然后把model存放到dataArray,然后再把dataArray 交给weiboTable;
    
    for (NSDictionary *dataDic in dicArray) {
        WeiboModel *model = [[WeiboModel alloc] initWithDataDic:dataDic];
        WeiboViewFrameLayout *layoutModel = [[WeiboViewFrameLayout alloc] init];
        layoutModel.model = model;
        [statusesArray addObject:layoutModel];
        
    }
    if (request.tag == 100) {
        _data = statusesArray;
        [self completeHud:@"加载完成"];
    } else if (request.tag == 101) {
        if (_data == nil) {
            _data = statusesArray;
        }else {
            NSRange range = NSMakeRange(0, statusesArray.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [_data insertObjects:statusesArray atIndexes:indexSet];
            [self showNewWeiboCount:statusesArray.count];
            
        }
    } else if (request.tag == 102) {
        if (_data == nil) {
            _data = statusesArray;
        } else {
            [_data removeLastObject];
            [_data addObjectsFromArray:statusesArray];
        }
        
    } if (_data.count != 0) {
        _weiboTableview.data = _data;
        [_weiboTableview reloadData];
    }
    [_weiboTableview.header endRefreshing];
    [_weiboTableview.footer endRefreshing];

    
}
- (void)showNewWeiboCount:(NSInteger) count {
    if (_barIamgeView == nil) {
        _barIamgeView = [[ThemeImageView alloc] initWithFrame:CGRectMake(5, -40, kScreenWidth - 10, 40)];
        _barIamgeView.imageName = @"timeline_notify.png";
        [self.view addSubview:_barIamgeView];
        
        _barLabel = [[ThemeLabel alloc] initWithFrame:_barIamgeView.bounds];
        _barLabel.colorName = @"Timeline_Notice_color";
        _barLabel.backgroundColor = [UIColor clearColor];
        _barLabel.textAlignment = NSTextAlignmentCenter;
        [_barIamgeView addSubview:_barLabel];
    }
    if (count >= 0) {
        _barLabel.text = [NSString stringWithFormat:@"更新了%li条weibo",count];
        [UIView animateWithDuration:0.6 animations:^{
            _barIamgeView.transform = CGAffineTransformMakeTranslation(0, 64+40+5);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.6 animations:^{
                [UIView setAnimationDelay:1];
                _barIamgeView.transform = CGAffineTransformIdentity;
                
            }];
            
        }];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        //注册系统声音
        SystemSoundID soundId;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundId);
        
        AudioServicesPlaySystemSound(soundId);
        
        
    }
}

@end
