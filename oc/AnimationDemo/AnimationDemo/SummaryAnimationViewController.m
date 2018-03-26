//
//  SummaryAnimationViewController.m
//  AnimationDemo
//
//  Created by dfang on 2018-3-27.
//  Copyright © 2018年 east. All rights reserved.
//

#import "SummaryAnimationViewController.h"

@interface SummaryAnimationViewController () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation SummaryAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"动画总结";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    [self addTestBtns];
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImage *image = [UIImage imageNamed:@"image"];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - image.size.width)/2, 100, image.size.width, image.size.height)];
        _imageView.image = image;
    }
    return _imageView;
}

- (void)addTestBtns {
    NSArray *titles = @[@"UIView", @"UIViewBlock", @"UIViewTransition", @"CoreAnimation"];
    
    // 每行显示三个按钮
    int columns = 3;
    // 计算总的行数
    int rows = titles.count / columns + (titles.count % columns == 0 ? 0 : 1);
    CGFloat width = 100;
    CGFloat height = 40;
    CGFloat paddingH = (self.view.frame.size.width - width * columns) / (columns + 1);
    CGFloat paddingV = 20;
    CGFloat top = self.view.frame.size.height - (height + paddingV) * rows;
    if (self.tabBarController.tabBar != nil) {
        top = top - self.tabBarController.tabBar.frame.size.height;
    }
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < titles.count; i++) {
        x = paddingH + (i % columns) * (width + paddingH);
        y = top + (i / columns) * (height + paddingV);
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
        btn.tag = i;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.borderWidth = 2;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

// 监听按钮事件，依据按钮title调用对应的处理方法
- (void)btnClicked: (UIButton *)button {
    SEL method = NSSelectorFromString([NSString stringWithFormat:@"test%@", button.titleLabel.text]);
    if ([self respondsToSelector:method]) {
        [self performSelector:method];
    } else {
        NSLog(@"未找到函数%@", [NSString stringWithFormat:@"test%@", button.titleLabel.text]);
    }
}

- (void)testUIView {
    [UIView beginAnimations:nil context:nil];
    //设置时间
    [UIView setAnimationDuration:3];
    
    //监听动画的完成
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stop)];
    
    //实现动画代码
    self.imageView.center = CGPointMake(80, 380);
    [UIView commitAnimations];
}

- (void)testUIViewBlock {
    [UIView animateWithDuration:3 animations:^{
        self.imageView.center = CGPointMake(200, 180);
    } completion:^(BOOL finished) {
        [self animationStop];
    }];
}

- (void)testUIViewTransition {
    [UIView transitionWithView:self.imageView duration:3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        //更改image的图片
        self.imageView.image = [UIImage imageNamed:@"2.jpg"];
    } completion:^(BOOL finished) {
        [self animationStop];
    }];
}

- (void)testCoreAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
    // 保持动画完成状态
//    animation.removedOnCompletion = false;
//    animation.fillMode = kCAFillModeBoth;
    //核心动画　要监听动画完成　设置代理
    animation.delegate = self;
    [self.imageView.layer addAnimation:animation forKey:nil];
}

// animationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationdelegate animationdidstop finished:%@", flag ? @"YES": @"NO");
    [self animationStop];
}

- (void)animationStop {
     NSLog(@"动画执行完成");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
