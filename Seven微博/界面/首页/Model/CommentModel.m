//
//  CommentModel.m
//  Seven微博
//
//  Created by mac on 15/10/16.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CommentModel.h"
#import "Utils.h"
@implementation CommentModel

- (void)setAttributes:(NSDictionary *)dataDic {
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
    self.user = user;
    
    NSDictionary *statusDic = [dataDic objectForKey:@"status"];
    WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statusDic];
    self.weibo = weibo;
    
    NSDictionary *commentDic = [dataDic objectForKey:@"reply_comment"];
    if (commentDic != nil) {
        CommentModel *comment = [[CommentModel alloc] initWithDataDic:commentDic];
        self.commentSource = comment;
        
    }
    
    //处理评论详情
    self.text = [Utils parseTextImage:_text];
    
    
}
@end
