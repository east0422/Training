//
//  WaterImageView.h
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-2.
//  Copyright © 2018年 east. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterImageView : UIImageView

/**
 @param bgImageName 背景图片
 @param waterImageName 水印图片
 @param scale 缩放比例
 @return 添加水印缩放的背景图片
 */
+ (UIImage *)waterImageWithBgImageName:(NSString *)bgImageName waterImageName:(NSString *)waterImageName scale:(CGFloat)scale;

@end
