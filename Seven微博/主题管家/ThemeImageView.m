//
//  ThemeImageView.m
//  WeiBo
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
}

- (void)themeDidChange:(NSNotification *)notification{
    [self loadImage];
}

- (void)setImageName:(NSString *)imageName{
    if (![_imageName isEqualToString:imageName]) {
        _imageName = [imageName copy];
        [self loadImage];
    }
    
}

- (void)loadImage{
    
    //得到管家对象
    ThemeManager *manager = [ThemeManager shareInstance];
    
    UIImage *image = [manager getThemeImage:self.imageName];
    image = [image stretchableImageWithLeftCapWidth:_leftCap topCapHeight:_topCap];

    if (image != nil) {
        self.image = image;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
