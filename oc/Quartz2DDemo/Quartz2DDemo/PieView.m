//
//  PieView.m
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-1.
//  Copyright © 2018年 east. All rights reserved.
//

#import "PieView.h"

@implementation PieView

- (void)drawRect:(CGRect)rect {
    float sum = 0;
    for (int i = 0; i < self.sections.count; i++) {
        sum = sum + [self.sections[i] floatValue];
    }

    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = 0;
    CGFloat radius = MIN(rect.size.width, rect.size.height) * 0.5;
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 0; i < self.sectionColors.count; i++) {
        endAngle = [self.sections[i] floatValue] / sum * 2 * M_PI + startAngle;
        UIColor *curColor = self.sectionColors[i];
        [curColor set];
        CGContextMoveToPoint(context, rect.size.width * 0.5, rect.size.height * 0.5);
        CGContextAddArc(context, rect.size.width * 0.5, rect.size.height * 0.5, radius, startAngle, endAngle, 0);
        CGContextFillPath(context);
        startAngle = endAngle;
    }
}

@end
