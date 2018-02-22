//
//  UIImage+Crop.m
//  CALayerDemo
//
//  Created by dfang on 2018-2-22.
//  Copyright © 2018年 east. All rights reserved.
//

#import "UIImage+Crop.h"

@implementation UIImage (Crop)

+ (UIImage *)cropImageWith:(NSString *)sourceName cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    UIImage *sourceImage = [UIImage imageNamed:sourceName];
    
    UIGraphicsBeginImageContext(sourceImage.size);
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height);
    layer.cornerRadius = cornerRadius;
    // 裁剪
    layer.masksToBounds = YES;
    layer.borderWidth = borderWidth;
    layer.borderColor = borderColor.CGColor;
    layer.contents = (id)sourceImage.CGImage;
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *cropImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cropImage;
}

@end
