//
//  ThemeLabel.m
//  WeiBo
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"

@implementation ThemeLabel

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
        
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChange:) name:kThemeDidChangeNotificationName object:nil];
    
    
}

- (void)themeDidChange:(NSNotification *)notification{
    
    [self loadColor];
}

- (void)setColorName:(NSString *)colorName{
    
    if (![_colorName isEqualToString:colorName]) {
        _colorName = [colorName copy];
        [self loadColor];
    }
}



- (void)loadColor{
    
    
    ThemeManager *manager = [ThemeManager shareInstance];
    
    self.textColor = [manager getThemeColor:self.colorName];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
