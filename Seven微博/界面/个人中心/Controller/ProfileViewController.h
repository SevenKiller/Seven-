//
//  ProfileViewController.h
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeibo.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
@interface ProfileViewController : BaseViewController<SinaWeiboRequestDelegate,UITableViewDataSource,UITableViewDelegate>{
    UITableView *_tableView;
    //头像
    ThemeImageView *_headerImageView;
    //昵称
    ThemeLabel *_nicknameLabel;
    //个人信息
    ThemeLabel *_messageLabel;
    //头像 个性签名
    ThemeLabel *_signatureLabel;
}

@end
