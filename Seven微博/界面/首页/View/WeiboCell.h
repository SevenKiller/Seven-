//
//  WeiboCell.h
//  Seven微博
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboViewFrameLayout.h"
#import "WeiboView.h"
@interface WeiboCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) IBOutlet UILabel *nikNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
@property (strong, nonatomic) IBOutlet UILabel *rePostLabel;
@property (strong, nonatomic) IBOutlet UILabel *srcLabel;

@property (strong,nonatomic) WeiboView *weiboView;
@property (strong, nonatomic) WeiboViewFrameLayout *layout;


@end
