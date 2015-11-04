//
//  UserView.h
//  Seven微博
//
//  Created by mac on 15/10/17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboModel.h"
@interface UserView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sourceLabel;
@property (strong, nonatomic) WeiboModel *weiboModel;
@end
