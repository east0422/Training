//
//  LockView.m
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-7.
//  Copyright © 2018年 east. All rights reserved.
//

#import "LockView.h"

@interface LockView ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *btns;
@property (nonatomic, strong) NSMutableArray<UIButton *> *selectedBtns;
@property (nonatomic, assign) CGPoint lastPoint;

@end

@implementation LockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBtns];
    }
    return self;
}

- (void)setBtns {
    CGFloat btnWidth = 74;
    CGFloat btnHeight = 74;
    CGFloat padding = (self.frame.size.width - btnWidth * 3)/4;
    CGFloat marginTop = (self.frame.size.height - self.frame.size.width)/2;
    for (int i = 0; i < 9; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(padding + (btnWidth + padding) * (i%3), marginTop + padding + (btnHeight + padding) * (i/3), btnWidth, btnHeight)];
        button.tag = i;
        [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        button.userInteractionEnabled = false;
        [self addSubview:button];
        [self.btns addObject:button];
    }
}

- (NSMutableArray<UIButton *> *)btns {
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray<UIButton *> *)selectedBtns {
    if (_selectedBtns == nil) {
        _selectedBtns = [NSMutableArray array];
    }
    return _selectedBtns;
}

- (void)drawRect:(CGRect)rect {
    if (self.selectedBtns.count < 1) {
        return;
    }
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [[UIColor greenColor] set];
    bezierPath.lineWidth = 5;
    bezierPath.lineJoinStyle = kCGLineJoinRound;
    bezierPath.lineCapStyle = kCGLineCapRound;
    
    NSMutableArray<UIButton *> *unselectedBtns = [NSMutableArray arrayWithArray:self.btns];
    [unselectedBtns removeObjectsInArray:self.selectedBtns];
    
    [bezierPath moveToPoint:self.selectedBtns[0].center];
    for (UIButton *btn in self.selectedBtns) {
        [bezierPath addLineToPoint:btn.center];
        [bezierPath moveToPoint:btn.center];
        
        for (UIButton *unselected in unselectedBtns) {
            if ([bezierPath containsPoint:unselected.center]) {
                unselected.selected = true;
                [self.selectedBtns insertObject:unselected atIndex:[self.selectedBtns indexOfObject:btn]];
                // 删除会有问题，不用理会unselectedBtns
//                [unselectedBtns removeObject:unselected];
            }
        }
    }
    
    [bezierPath addLineToPoint:self.lastPoint];
    [bezierPath stroke];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    for (UIButton *btn in self.btns) {
        if (CGRectContainsPoint(btn.frame, touchPoint)) {
            if (!btn.isSelected) {
                btn.selected = true;
                [self.selectedBtns addObject:btn];
                self.lastPoint = touchPoint;
            }
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    for (UIButton *btn in self.btns) {
        if (CGRectContainsPoint(btn.frame, touchPoint)) {
            if (!btn.isSelected) {
                btn.selected = true;
                [self.selectedBtns addObject:btn];
            }
            self.lastPoint = touchPoint;
        } else {
            self.lastPoint = touchPoint;
        }
    }
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSMutableString *pwd = [NSMutableString string];
    for (UIButton *btn in self.selectedBtns) {
        [pwd appendFormat:@"%ld", (long)btn.tag];
        btn.selected = false;
    }
    [self.selectedBtns removeAllObjects];
    [self setNeedsDisplay];
    
    if ([self.delegate respondsToSelector:@selector(unlockWithPassword:)]) {
        [self.delegate unlockWithPassword:pwd];
    }
}

@end
