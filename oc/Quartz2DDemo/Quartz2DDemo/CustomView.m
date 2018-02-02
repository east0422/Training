//
//  CustomView.m
//  Quartz2DDemo
//
//  Created by dfang on 2018-1-26.
//  Copyright © 2018年 east. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)drawRect:(CGRect)rect {
//    [self drawLine];
//    [self drawTriangle];
//    [self drawArc];
//    [self drawSector];
    
//    [self drawText:@"没钱没工作hhohooh   ehh虎吼合法 u 发哈粉红啊 u哦 i 激发品牌【i 哦啊发哈富豪 i啊老啦啊就大大护发护肤啊哈佛啊哈佛啊哈哈哈hohaofhau-ieuraporj弘扬以后发货发"];
    
//    [self drawRotate];
//    [self clipImage];
    
//    [self uiDraw];
    [self drawPath];
}

// 绘制直线
- (void)drawLine {
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 保存一个当前上下文的绘图状态到一个栈里面
    CGContextSaveGState(context);
    // 恢复上下文，保存多少次就可以调用多少次
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    // 设置颜色
    CGContextSetRGBStrokeColor(context, 0.0, 0.7, 0.0, 1);
    // 设置宽度
    CGContextSetLineWidth(context, 14);
    // 设置线条头尾样式
    CGContextSetLineCap(context, kCGLineCapButt);
    // 设置起点
    CGContextMoveToPoint(context, 50, 50);
    // 连接另一个点
    CGContextAddLineToPoint(context, 150, 150);
    // 连接点样式
    CGContextSetLineJoin(context, kCGLineJoinRound);
    // 连接到另一个点
    CGContextAddLineToPoint(context, 300, 50);
    // 渲染
    CGContextStrokePath(context);
}

// 绘制三角形
- (void)drawTriangle {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 150, 50);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextAddLineToPoint(context, 180, 200);
    // 关闭路径，否则还需绘制终点到起点
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

// 绘制弧形
- (void)drawArc {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 60, 60);
    CGContextAddArc(context, 100, 100, 80, 0, M_PI_4, 1);
    CGContextStrokePath(context);
}

// 绘制扇形
- (void)drawSector {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, 100, 100);
    CGContextAddArc(context, 100, 100, 80, M_PI_4, 3 * M_PI_4, 0);
    CGContextClosePath(context);
    // 边线扇形
//    CGContextStrokePath(context);
    // 填充扇形
    CGContextFillPath(context);
}

// 绘制文字
- (void)drawText:(NSString *)text {
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                           NSForegroundColorAttributeName: [UIColor greenColor]
                           };
    [text drawInRect:CGRectMake(20, 50, self.frame.size.width - 40, self.frame.size.height * 0.5) withAttributes:attr];
}

// 平移/缩放/旋转
- (void)drawRotate {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 平移
    CGContextTranslateCTM(context, 50, 80);
    // 缩放
    CGContextScaleCTM(context, 1.5, 1.5);
    // 旋转
    CGContextRotateCTM(context, -M_PI_4);
    
    // 平移、缩放、旋转需在绘制前
    // 定义三个点
    CGPoint points[3] = {{50, 20}, {100, 80}, {10, 80}};
    CGContextAddLines(context, points, 3);
    
    // 合并三个点的路径
    CGContextClosePath(context);
    
    // 画线, 依照先后顺序连接
    CGPoint linePoints[2] = {{10, 20}, {80, 80}};
    CGContextAddLines(context, linePoints, 2);
    CGContextStrokePath(context);
}

- (void)clipImage {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(context, self.frame);
    // 裁剪
    CGContextClip(context);
    UIImage *image = [UIImage imageNamed:@"papa"];
    [image drawInRect:self.frame];
    CGContextSetLineWidth(context, 15);
    [[UIColor yellowColor] set];
    CGContextAddEllipseInRect(context, self.frame);
    // 渲染
    CGContextStrokePath(context);
}

- (void)uiDraw {
    // UIKit的方法不用获取上下文，但内部会获取上下文进行绘制
    //画实心
    UIRectFill(CGRectMake(10, 10, 100, 100));
    //画空心
    UIRectFrame(CGRectMake(10, 130, 50, 50));
}

- (void)drawPath {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 先定义好所有路径再一次添加到上下文中
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(50, 50, 100, 100));
    CGPathMoveToPoint(path, NULL, 250, 250);
    CGPathAddArc(path, NULL, 150, 250, 100, 0, M_PI, 0);
    // 路径添加到上下文
    CGContextAddPath(context, path);
    // 渲染
    CGContextStrokePath(context);
    // ARC环境C语言的资源是不会自动释放；需要释放path, 以create，retain,copy创建的需释放
    CGPathRelease(path);
    // 通用释放
//    CFRelease(path);
}

@end
