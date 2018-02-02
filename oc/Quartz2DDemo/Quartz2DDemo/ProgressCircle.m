//
//  ProgressCircle.m
//  Quartz2DDemo
//
//  Created by dfang on 2018-1-31.
//  Copyright © 2018年 east. All rights reserved.
//

#import "ProgressCircle.h"

@implementation ProgressCircle

- (void)drawRect:(CGRect)rect {
    CGFloat rectW = rect.size.width;
    CGFloat rectH = rect.size.height;
    NSString *proText = [NSString stringWithFormat:@"%.2f", self.progress];
    [proText drawInRect:CGRectMake((rectW - 30) * 0.5, (rectH - 20) * 0.5, 30, 20) withAttributes:nil];
    // 依据进度条值绘制圆圈
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 会多一条从当前点到弧线起点的直线
//    CGContextMoveToPoint(context, rectW * 0.5, rectH * 0.5);
    CGFloat radius = (MIN(rectH, rectW) - 10) * 0.5;
    CGContextAddArc(context, rectW * 0.5, rectH * 0.5, radius, -M_PI_2, self.progress * 2 * M_PI - M_PI_2, 0);
    CGContextStrokePath(context);
    
}

- (void)setProgress:(float)progress {
    _progress = progress;
    // 重绘
    [self setNeedsDisplay];
}

@end
