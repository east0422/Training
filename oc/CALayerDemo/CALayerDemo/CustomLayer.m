//
//  CustomLayer.m
//  CALayerDemo
//
//  Created by dfang on 2018-2-23.
//  Copyright © 2018年 east. All rights reserved.
//

#import "CustomLayer.h"

@implementation CustomLayer

// UIView在显示的时候，会先调用drawRect方法，然后调用图层的drawInContext
- (void)drawInContext:(CGContextRef)ctx {
    CGContextFillEllipseInRect(ctx, CGRectMake(0, 0, 100, 100));
}

@end
