//
//  ThemeManager.h
//  WeiBo
//
//  Created by mac on 15/10/9.
//  Copyright (c) 2015年 Janie. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ThemeManager : NSObject

@property (nonatomic, copy) NSString *themeName;//主题名字
@property (nonatomic, strong) NSDictionary *themeConfig;//theme.plist的内容
@property (nonatomic,strong)NSDictionary *colorConfig;//每个主题目录下 config.plist内容（颜色值）

//单例类方法 获得唯一对象
+ (ThemeManager *)shareInstance;

//根据图片名字获取对应主题包下的图片
- (UIImage *)getThemeImage:(NSString *)imageName;

- (UIColor *)getThemeColor:(NSString *)colorName;

@end
