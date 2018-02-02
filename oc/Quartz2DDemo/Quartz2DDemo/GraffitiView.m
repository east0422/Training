//
//  GraffitiView.m
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-7.
//  Copyright © 2018年 east. All rights reserved.
//

#import "GraffitiView.h"

@interface GraffitiView ()

@property (nonatomic, strong) NSMutableArray<UIBezierPath *> *lines;
@property (nonatomic, strong) NSMutableArray<UIColor *> *lineColors;

@end

@implementation GraffitiView

- (NSMutableArray<UIBezierPath *> *)lines {
    if (_lines == nil) {
        _lines = [NSMutableArray array];
    }
    return _lines;
}

- (NSMutableArray<UIColor *> *)lineColors {
    if (_lineColors == nil) {
        _lineColors = [NSMutableArray array];
    }
    return _lineColors;
}

- (UIColor *)currentColor {
    if (_currentColor == nil) {
        _currentColor = [UIColor blackColor];
    }
    return _currentColor;
}

- (void)drawRect:(CGRect)rect {
    for (UIBezierPath *bezierPath in self.lines) {
        // 设置颜色
        [[self.lineColors objectAtIndex:[self.lines indexOfObject:bezierPath]] set];
        [bezierPath setLineWidth:5];
        [bezierPath setLineJoinStyle:kCGLineJoinRound];
        [bezierPath setLineCapStyle:kCGLineCapRound];
        [bezierPath stroke];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:[[touches anyObject] locationInView:self]];
    [self.lines addObject:bezierPath];
    [self.lineColors addObject:self.currentColor];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[self.lines lastObject] addLineToPoint:[[touches anyObject] locationInView:self]];
    [self setNeedsDisplay];
}

- (void)backClicked {
    [self.lines removeLastObject];
    [self.lineColors removeLastObject];
    [self setNeedsDisplay];
}

- (void)clearClicked {
    [self.lines removeAllObjects];
    [self.lineColors removeAllObjects];
    [self setNeedsDisplay];
}

- (void)saveClicked {
    UIGraphicsBeginImageContext(self.frame.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(screenshot, self, nil, nil);
}

@end
