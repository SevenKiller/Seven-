//
//  WeibotableView.h
//  Seven微博
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeibotableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSArray *data;
@end
