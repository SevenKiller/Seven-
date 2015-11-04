//
//  WeiboAnnotationView.m
//  Seven微博
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WeiboAnnotation.h"
#import "UIImageView+WebCache.h"

@implementation WeiboAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 140, 40);
        [self _createViews];
    }
    return self;
}
- (void)_createViews {
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    _headerImageView.image = [UIImage imageNamed:@"icon"];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 40)];
    _textLabel.text = @"初代七杀";
    
    [self addSubview:_textLabel];
    [self addSubview:_headerImageView];
    
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    WeiboAnnotation *annotation = self.annotation;
    WeiboModel *model = annotation.model;
    //微博内容
    _textLabel.text = model.text;
    _textLabel.font = [UIFont systemFontOfSize:10];
    _textLabel.numberOfLines = 3;
    
    //头像
    NSString *urlStr = model.userModel.profile_image_url;
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"icon"]];
    

}
@end
