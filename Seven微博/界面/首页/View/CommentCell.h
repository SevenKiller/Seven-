//
//  CommentCell.h
//  Seven微博
//
//  Created by mac on 15/10/17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
#import "WXLabel.h"
@interface CommentCell : UITableViewCell<WXLabelDelegate> {
    
    __weak IBOutlet UIImageView *imageView;
    
    __weak IBOutlet UILabel *nameLabel;
    
    WXLabel *_commentTextLabel;
}
@property (strong, nonatomic) CommentModel *commentModel;
//计算评论单元格的高度
+ (float)getCommentHeight:(CommentModel *)commentModel;

@end
