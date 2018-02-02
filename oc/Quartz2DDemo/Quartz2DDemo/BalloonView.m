//
//  BalloonView.m
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-1.
//  Copyright © 2018年 east. All rights reserved.
//

#import "BalloonView.h"

@interface BalloonView ()

//@property (nonatomic, assign) CGPoint position;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic, strong) NSMutableArray *balloons;
@property (nonatomic, assign) NSTimer *timer;
@property (nonatomic, assign) CADisplayLink *displaylink;

@end

@implementation BalloonView

- (void)drawRect:(CGRect)rect {
    NSLog(@"drawRect=====================");
    // 一个气球上浮
//    CGPoint newPosition = self.position;
//    if (newPosition.y < 20) {
//        newPosition.y = rect.size.height - 30;
//    } else {
//        newPosition.y -= 10;
//    }
//    newPosition.x = rect.size.width * 0.5;
//    self.position = newPosition;
//    UIImage *image = [UIImage imageNamed:@"balloon"];
//    [image drawAtPoint:self.position];
    
    // 多个气球上浮
    for (int i = 0; i < self.balloons.count; i++) {
        CGPoint newPosition = [self.locations[i] CGPointValue];
        if (newPosition.y < 20) {
            newPosition.y = rect.size.height - 30;
        } else {
            newPosition.y -= arc4random_uniform(10);
        }
        [self.locations replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint: newPosition]];
        UIImage *image = self.balloons[i];
        [image drawAtPoint:newPosition];
    }
}

- (NSMutableArray *)locations {
    if (_locations == nil) {
        _locations = [NSMutableArray array];
    }
    return _locations;
}

- (NSMutableArray *)balloons {
    if (_balloons == nil) {
        NSInteger cout = 6;
        _balloons = [NSMutableArray arrayWithCapacity:cout];
        CGFloat marginLeft = 40;
        CGFloat ballonDelta = 50;
        UIImage *balloonImage = [UIImage imageNamed:@"balloon"];
        for (int i = 0; i < cout; i++) {
            [_balloons addObject:balloonImage];
            [self.locations addObject:[NSValue valueWithCGPoint:CGPointMake(marginLeft + i * ballonDelta, self.frame.size.height - 30)]];
        }
    }
    return _balloons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"initWithFrame---------------");
    self = [super initWithFrame:frame];
    if (self) {
        [self addAnimation];
    }
    return self;
}

- (instancetype)init
{
    NSLog(@"init---------------");
    self = [super init];
    if (self) {
        [self addAnimation];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // method 1
//    [self.timer invalidate];
    
    // method 2
//    [self.displaylink invalidate];
}

- (void)addAnimation {
    // method 1.1
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self setNeedsDisplay];
//    }];
     // method 1.2
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
    
    // method 2.1 直接使用需设置displaylink为strong
//    self.displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
//    [self.displaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    // method 2.2 displaylink可为assign
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    // default is 60
    link.preferredFramesPerSecond = 10;
    self.displaylink = link;
}

@end
