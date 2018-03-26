//
//  KeyFrameAnimationViewController.m
//  AnimationDemo
//
//  Created by dfang on 2018-3-27.
//  Copyright © 2018年 east. All rights reserved.
//

#import "KeyFrameAnimationViewController.h"

@interface KeyFrameAnimationViewController ()

@property (nonatomic, strong) UIView *redView;

@end

static const CGFloat radius = 150;
static const CGFloat left = 10;
static const CGFloat top = 100;
static const CGFloat redRadius = 10;

@implementation KeyFrameAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"帧动画演示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(left, top, radius * 2, radius * 2)];
    circleView.backgroundColor = [UIColor lightGrayColor];
    circleView.layer.cornerRadius = radius;
    circleView.layer.borderWidth = 1.5;
    [self.view addSubview:circleView];
    
    [self.view addSubview:self.redView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, top + radius * 2 + 50, self.view.frame.size.width, 40)];
    [button setTitle:@"KeyFrameAnimation" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.3;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (UIView *)redView {
    if (_redView == nil) {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(left + radius - redRadius, top - redRadius, redRadius * 2, redRadius * 2)];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (void)btnClicked {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.duration = 3;
    // 保持动画结束状态
    animation.removedOnCompletion = false;
    animation.fillMode = kCAFillModeForwards;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, left + radius, top + radius, radius, -M_PI_2, M_PI_2 * 3, false);
    // path优先级高于values，故同时设置了values和path会忽略values
    animation.path = path;
    // 释放
    CGPathRelease(path);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    // 动画一直持续下去不停止
//    animation.repeatCount = MAXFLOAT;
    [self.redView.layer addAnimation:animation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
