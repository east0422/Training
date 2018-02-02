//
//  WaterImageView.m
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-2.
//  Copyright © 2018年 east. All rights reserved.
//

#import "WaterImageView.h"

@implementation WaterImageView

+ (UIImage *)waterImageWithBgImageName:(NSString *)bgImageName waterImageName:(NSString *)waterImageName scale:(CGFloat)scale {
    UIImage *bgImage = [UIImage imageNamed:bgImageName];
    // 开始位图上下文
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, scale);
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    UIImage *waterImage = [UIImage imageNamed:waterImageName];
    // 水印图片缩放比例
    CGFloat waterScale = 0.4;
    CGFloat waterW = waterImage.size.width * waterScale;
    CGFloat waterH = waterImage.size.height * waterScale;
    CGFloat waterX = bgImage.size.width - waterW;
    CGFloat waterY = bgImage.size.height - waterH;
    [waterImage drawInRect:CGRectMake(waterX, waterY, waterW, waterH)];
    
    // 从位图上下文中获取当前编辑图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束当前编辑
    UIGraphicsEndImageContext();
    return newImage;
}

@end
