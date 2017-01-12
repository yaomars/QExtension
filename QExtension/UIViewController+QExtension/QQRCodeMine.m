//
//  QQRCodeMine.m
//  QExtension
//
//  Created by JHQ0228 on 2017/1/11.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "QQRCodeMine.h"
#import "UIImage+QRCode.h"

NS_ASSUME_NONNULL_BEGIN


#define WIDTH   [UIScreen mainScreen].bounds.size.width
#define HEIGHT  [UIScreen mainScreen].bounds.size.height

@interface QQRCodeMine ()

@end

@implementation QQRCodeMine

+ (instancetype)qrCodeWithInfo:(NSString *)info headIcon:(UIImage *)headIcon {
    
    QQRCodeMine *qrCode = [[self alloc] init];
    
    qrCode.view.backgroundColor = [UIColor whiteColor];
    
    qrCode.myQRCodeInfo = info;
    qrCode.headIcon = headIcon;
    
    [qrCode creatdMyQRCodeView];
    
    return qrCode;
}

/// 创建自定义扫描界面
- (void)creatdMyQRCodeView {
    
    // 创建假导航
    
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath]
                            stringByAppendingPathComponent:@"QQRCode.bundle"];
    
    UIImageView *navImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    navImageView.image = [UIImage imageWithContentsOfFile:
                          [bundlePath stringByAppendingPathComponent:@"scan_navbar"]];
    navImageView.userInteractionEnabled = YES;
    [self.view addSubview:navImageView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH / 2 - 100, 20 , 200, 44)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的二维码";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navImageView addSubview:titleLabel];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backPressed = [UIImage imageWithContentsOfFile:
                            [bundlePath stringByAppendingPathComponent:@"btn_back_pressed"]];
    UIImage *backNor = [UIImage imageWithContentsOfFile:
                        [bundlePath stringByAppendingPathComponent:@"btn_back_nor"]];
    [backButton setImage:backPressed forState:UIControlStateHighlighted];
    [backButton setImage:backNor forState:UIControlStateNormal];
    [backButton setFrame:CGRectMake(10, 15, 48, 48)];
    [backButton addTarget:self action:@selector(pressBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [navImageView addSubview:backButton];
    
    // 创建我的二维码视图
    
    CGFloat margin = 50;
    CGRect frame = CGRectMake(margin,
                              margin + 64,
                              self.view.bounds.size.width - margin * 2,
                              self.view.bounds.size.width - margin * 2);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    [self.view addSubview:imageView];
    
    UIImage *qrImage = [UIImage q_imageWithQRCodeFromString:self.myQRCodeInfo
                                                   headIcon:self.headIcon
                                                      color:nil
                                                  backColor:nil];
    imageView.image = qrImage;
}

/// 返回按钮点击事件处理
- (void)pressBackButton:(UIButton *)btn {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end


NS_ASSUME_NONNULL_END