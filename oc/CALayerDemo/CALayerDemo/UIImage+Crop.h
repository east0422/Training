//
//  UIImage+Crop.h
//  CALayerDemo
//
//  Created by dfang on 2018-2-22.
//  Copyright © 2018年 east. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Crop)

+ (UIImage *)cropImageWith: (NSString *)sourceName cornerRadius: (CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor: (UIColor *)borderColor;

@end
