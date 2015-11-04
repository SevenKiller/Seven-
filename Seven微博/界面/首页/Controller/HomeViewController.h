//
//  HomeViewController.h
//  WeiBo
//
//  Created by mac on 15/10/8.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeibo.h"
#import "WeibotableView.h"
#import "ThemeLabel.h"
@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate>
{
    
    WeibotableView *_weiboTableView;
}
//@property (nonatomic,copy)
@end
