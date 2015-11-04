//
//  personalViewController.h
//  Seven微博
//
//  Created by mac on 15/10/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "SinaWeibo.h"
#import "WeibotableView.h"
@interface personalViewController : BaseViewController<SinaWeiboRequestDelegate>
{
    WeibotableView *_weiboTableview;
}
@end
