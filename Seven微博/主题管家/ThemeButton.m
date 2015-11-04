//
//  ThemeButton.m
//  WeiBo
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //注册通知观察者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    }
    return self;
}

- (void)themeDidChange:(NSNotification *)notification{
    [self loadImage];
}

- (void)setNormalImageName:(NSString *)normalImageName{
    if (![_normalImageName isEqualToString:normalImageName]) {
        _normalImageName = [normalImageName copy];
        [self loadImage];
    }
    
}

- (void)setBgNormalImageName:(NSString *)bgNormalImageName{
    if (![_bgNormalImageName isEqualToString:bgNormalImageName]) {
        _bgNormalImageName = [bgNormalImageName copy];
        [self loadImage];
    }
    
}


- (void)loadImage{
    
    //得到管家对象
    ThemeManager *manager = [ThemeManager shareInstance];
    
    if (_normalImageName != nil) {
        UIImage *image = [manager getThemeImage:_normalImageName];
        if (image != nil) {
            [self setImage:image forState:UIControlStateNormal];
        }
    }
    
    if (_bgNormalImageName != nil) {
        UIImage *image = [manager getThemeImage:_bgNormalImageName];
        if (image != nil) {
            [self setBackgroundImage:image forState:UIControlStateNormal];
        }
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
