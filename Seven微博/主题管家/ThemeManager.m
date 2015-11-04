//
//  ThemeManager.m
//  WeiBo
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import "ThemeManager.h"

@implementation ThemeManager

//单例类方法 获得唯一对象
+ (ThemeManager *)shareInstance{
    static ThemeManager *instance = nil;
    
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        //ThemeManager
        instance = [[[self class] alloc] init];
    });
    NSLog(@"instance = %@",instance);
    return  instance;
    
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
        //1.读取本地持久化存储的主题名字
        _themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        if (_themeName.length == 0) {
            _themeName = @"Dark Fairy";//如果本地没有存储主题名字，则用默认Dark Fairy
        }
        
        //2.读取主题名 获取主题路径 配置文件 放到字典里面
        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        
        self.themeConfig = [NSDictionary dictionaryWithContentsOfFile:configPath];
        
        //3.读取颜色配置
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        _colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
    }
    return  self;
}

//设置主题名字 触发通知
- (void)setThemeName:(NSString *)themeName{
    
    if (![_themeName isEqualToString:themeName]) {
        _themeName = [themeName copy];
        //01 把主题名字存储到plist中 NSUserDefaults
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        //02 重新读取颜色配置文件
        NSString *themePath = [self themePath];
        NSString *filePath = [themePath stringByAppendingPathComponent:@"config.plist"];
        self.colorConfig = [NSDictionary dictionaryWithContentsOfFile:filePath];
        
        //03 发通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotificationName object:nil];
    }
    
    
}

//主题包路径获取
- (NSString *)themePath{
    //1.获取主题包根路径
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    
    //2.当前主题包的路径
    NSString *themePath = [self.themeConfig objectForKey:self.themeName];
    
    //3.完整路径
    NSString *path = [bundlePath stringByAppendingPathComponent:themePath];
    
    return path;
}

//根据图片名字获取对应主题包下的图片
- (UIImage *)getThemeImage:(NSString *)imageName{
    //得到图片路径
    //1.得到主题包路径
    NSString *themePath = [self themePath];
    
    //2.拼接图片路径
    NSString *filePath = [themePath stringByAppendingPathComponent:imageName];
    
    //3.读取图片
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

- (UIColor *)getThemeColor:(NSString *)colorName{
    
    if (colorName.length == 0) {
        return  nil;
    }
    //获取 配置文件中  rgb值
    NSDictionary *rgbDic = [_colorConfig objectForKey:colorName];
    CGFloat r  = [rgbDic[@"R"] floatValue];
    CGFloat g  = [rgbDic[@"G"] floatValue];
    CGFloat b  = [rgbDic[@"B"] floatValue];
    
    CGFloat alpha = 1;
    
    
    if (rgbDic[@"alpha"] != nil) {
        alpha = [rgbDic[@"alpha"] floatValue];
    }
    //通过rgb值创建UIColor对象
    UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
    
    return color;
    
}

@end
