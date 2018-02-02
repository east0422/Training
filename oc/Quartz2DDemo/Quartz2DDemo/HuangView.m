//
//  HuangView.m
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-1.
//  Copyright © 2018年 east. All rights reserved.
//

#import "HuangView.h"

@implementation HuangView

- (void)drawRect:(CGRect)rect {
    CGFloat marginTop = 50;
    CGFloat radius = 80;
    CGFloat middleH = 150;
    CGFloat glassH = 30;
    CGFloat rectW = rect.size.width;
    
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置填充颜色为黄色
//    [[UIColor yellowColor] set];
    CGContextSetRGBFillColor(context, 1.0, 1.0, 0, 1);
    // 绘制小黄人头部半圆
    CGContextAddArc(context, rectW * 0.5, marginTop + radius, radius, 0, M_PI, 1);
    // 绘制小黄人身体
    CGContextAddRect(context, CGRectMake(rectW * 0.5 - radius, marginTop + radius, radius * 2, middleH));
    // 绘制小黄人底部
    CGContextAddArc(context, rectW * 0.5, marginTop + radius + middleH, radius, 0, M_PI, 0);
    // 渲染
    CGContextFillPath(context);
    
    // 更改填充颜色为黑色
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    // 绘制眼眶
    CGFloat padding = 5;
    CGContextAddRect(context, CGRectMake(rectW * 0.5 - radius - padding, marginTop + radius, (radius + padding) * 2, glassH));
    CGContextFillPath(context);
    
    // 更改填充颜色为白色
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1);
    CGFloat whiteRadius = radius * 0.4;
    CGContextAddArc(context, rectW * 0.5 - whiteRadius, marginTop + radius + glassH * 0.5, whiteRadius, 0, 2 * M_PI, 0);
    CGContextAddArc(context, rectW * 0.5 + whiteRadius, marginTop + radius + glassH * 0.5, whiteRadius, 0, 2 * M_PI, 0);
    CGContextFillPath(context);
    
    // 设置线条宽度为10
    CGContextSetLineWidth(context, 10);
    // 更改线条颜色为黑线
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextAddArc(context, rectW * 0.5 - whiteRadius, marginTop + radius + glassH * 0.5, whiteRadius, 0, 2 * M_PI, 0);
    CGContextMoveToPoint(context,  rectW * 0.5 + whiteRadius * 2, marginTop + radius + glassH * 0.5);
    CGContextAddArc(context, rectW * 0.5 + whiteRadius, marginTop + radius + glassH * 0.5, whiteRadius, 0, 2 * M_PI, 0);
    // 渲染
    CGContextStrokePath(context);
    
    // 绘制眼球
    CGContextSetRGBFillColor(context, 139/255.0, 105/255.0, 105/255.0, 1);
    CGFloat eyeballRadius = radius * 0.2;
    CGContextAddArc(context, rectW * 0.5 - eyeballRadius - 10, marginTop + radius + glassH * 0.5, eyeballRadius, 0, 2 * M_PI, 0);
    CGContextAddArc(context, rectW * 0.5 + eyeballRadius + 10, marginTop + radius + glassH * 0.5, eyeballRadius, 0, 2 * M_PI, 0);
    CGContextFillPath(context);
    
    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1);
    CGContextAddArc(context, rectW * 0.5 - eyeballRadius - 10, marginTop + radius + glassH * 0.5, eyeballRadius * 0.5, 0, 2 * M_PI, 0);
    CGContextAddArc(context, rectW * 0.5 + eyeballRadius + 10, marginTop + radius + glassH * 0.5, eyeballRadius * 0.5, 0, 2 * M_PI, 0);
    CGContextFillPath(context);
    
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1);
    CGContextAddArc(context, rectW * 0.5 - eyeballRadius * 1.1 - 10, marginTop + radius + glassH * 0.5 - eyeballRadius * 0.1, eyeballRadius * 0.1, 0, 2 * M_PI, 0);
    CGContextAddArc(context, rectW * 0.5 + eyeballRadius * 0.9 + 10, marginTop + radius + glassH * 0.5 - eyeballRadius * 0.1, eyeballRadius * 0.1, 0, 2 * M_PI, 0);
    CGContextFillPath(context);
    
    // 嘴巴
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
    CGContextSetLineWidth(context, 2);
    CGContextAddArc(context, rectW * 0.5, marginTop + radius + middleH * 0.5, middleH * 0.3, M_PI_4, 3 * M_PI_4, 0);
    CGContextStrokePath(context);
    
    // 头发
    CGContextSetLineWidth(context, 1);
    // 中间
    CGContextMoveToPoint(context, rectW * 0.5, marginTop + 20);
    CGContextAddLineToPoint(context, rectW * 0.5, marginTop - 20);
    // 左边
    CGContextMoveToPoint(context, rectW * 0.5 -  10, marginTop + 20);
    CGContextAddLineToPoint(context, rectW * 0.5 - 30, marginTop - 20);
    // 最左边
    CGContextMoveToPoint(context, rectW * 0.5 - 20, marginTop + 20);
    CGContextAddLineToPoint(context, rectW * 0.5 - 50, marginTop - 20);
    // 右边
    CGContextMoveToPoint(context, rectW * 0.5 + 10, marginTop + 20);
    CGContextAddLineToPoint(context, rectW * 0.5 + 30, marginTop - 20);
    // 最右边
    CGContextMoveToPoint(context, rectW * 0.5 + 20, marginTop + 20);
    CGContextAddLineToPoint(context, rectW * 0.5 + 50, marginTop - 20);
    CGContextStrokePath(context);
}

@end
