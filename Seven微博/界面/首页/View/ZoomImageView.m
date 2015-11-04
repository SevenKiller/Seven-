//
//  ZoomImageView.m
//  Seven微博
//
//  Created by mac on 15/10/17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ZoomImageView.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
@implementation ZoomImageView {
    NSURLConnection *_connection;
    MBProgressHUD *_hud;
    double _length;
    NSMutableData *_data;
   
}
- (instancetype)init {

    if (self = [super init]) {
        [self initTap];
        [self _createIconView];
    }
    return self;
}
#pragma mark - 创建gif图标
- (void)_createIconView {
    _iconView = [[UIImageView alloc] init];
    _iconView.image = [UIImage imageNamed:@"timeline_gif.png"];
    [self addSubview:_iconView];
}
#pragma mark - 添加手势
- (void)initTap{
    //01 打开交互
    self.userInteractionEnabled = YES;
    //02 创建放大单击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomIn)];
    [self addGestureRecognizer:tap];
    
    self.contentMode = UIViewContentModeScaleAspectFit;
    //03 修改内容模式
    self.contentMode = UIViewContentModeScaleAspectFit;
    
    
}

- (void)zoomIn{
    if ([self.delegate respondsToSelector:@selector(imageWillZoomIn:)]) {
        [self.delegate imageWillZoomIn:self];
    }
    
    //01 创建缩放视图
    [self createViews];
    //02 把相对于cell的frame转换成相对于window的frame
    CGRect frame = [self convertRect:self.bounds toView:self.window];
    _fullImageView.frame = frame;
    //03 动画
    self.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        _fullImageView.frame = _scrollView.frame;
    } completion:^(BOOL finished) {
        _scrollView.backgroundColor = [UIColor blackColor];
        //下载图片
        [self downLoadImage];
        
    }];

    
}

- (void)createViews{
    
    if (_scrollView == nil) {
        
        //01 scrollView 添加到window上
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [self.window addSubview:_scrollView];
        
        
        //02  大图显示
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.image = self.image;
        [_scrollView addSubview:_fullImageView];
        
        //03  缩小手势
        UITapGestureRecognizer *small = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOut)];
        [_scrollView addGestureRecognizer:small];
        
        //04  添加长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(savePhotods:)];
        
        [_scrollView addGestureRecognizer:longPress];

    }
    
}
#pragma mark - 保存图片到相册
- (void)savePhotods:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存图片" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UIImage *image = _fullImageView.image;
        
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.window animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //显示模式改为：自定义视图模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"保存成功";
    
    //延迟隐藏
    [hud hide:YES afterDelay:1.5];
    }
#pragma mark - 缩小图片
- (void)zoomOut {
    
    if ([self.delegate respondsToSelector:@selector(imageWillZoomOut:)]) {
        [self.delegate imageWillZoomOut:self];
    }
    
    _scrollView.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.35 animations:^{
        CGRect frame = [self convertRect:self.bounds toView:self.window];
        
        _fullImageView.frame = frame;
        
        //如果scroll内容偏移,偏移量也要考虑进去
        _fullImageView.top += _scrollView.contentOffset.y;
        
    } completion:^(BOOL finished) {
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        _fullImageView = nil;
        self.hidden = NO;
        
    }];

}
- (void)downLoadImage {
    if (_fullImgUrlStr.length != 0) {
        
        //下载进度显示
        _hud = [MBProgressHUD showHUDAddedTo:_scrollView animated:YES];
        _hud.mode = MBProgressHUDModeDeterminate;
        _hud.progress = 0.0;
        
        NSURL *url = [NSURL URLWithString:_fullImgUrlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        
        _connection =  [NSURLConnection connectionWithRequest:request delegate:self];
        
        
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //01 获取响应头
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
    
    NSDictionary *headFields =  [httpResponse allHeaderFields];
    NSLog(@"%@",headFields);
    
    
    NSString *lengthStr  = [headFields objectForKey:@"Content-Length"];
    
    _length = [lengthStr doubleValue];
    
    _data = [[NSMutableData alloc]init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_data appendData:data];
    CGFloat progress = _data.length/_length;
    _hud.progress = progress;
    NSLog(@"进度  %f",progress);
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    NSLog(@"下载完毕");
    [_hud hide:YES];
    
    UIImage *image = [UIImage imageWithData:_data];
    
    _fullImageView.image = image;
    
    
    //尺寸处理
    // kScreenWidth/length = image.size.width/image.size.height
    
    CGFloat length = image.size.height/image.size.width * kScreenWidth;
    if (length > kScreenHeight) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _fullImageView.height = length;
            _scrollView.contentSize = CGSizeMake(kScreenWidth, length);
            
        }];
        
    }
 
}
- (void)showGif {
    _fullImageView.image = [UIImage sd_animatedGIFWithData:_data];
    
    
}
@end
