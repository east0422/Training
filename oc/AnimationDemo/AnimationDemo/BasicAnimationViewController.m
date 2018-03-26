//
//  BasicAnimationViewController.m
//  AnimationDemo
//
//  Created by dfang on 2018-3-27.
//  Copyright © 2018年 east. All rights reserved.
//

#import "BasicAnimationViewController.h"

@interface BasicAnimationViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation BasicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"基本动画演示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加图片
    [self.view addSubview:self.imageView];
    
    // 添加测试按钮
    [self addTestBtns];
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImage *image = [UIImage imageNamed:@"image"];
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.frame = CGRectMake((self.view.frame.size.width - image.size.width )/2, 100, image.size.width, image.size.height);
    }
    return _imageView;
}

- (void)addTestBtns {
    NSArray *titles = @[@"Rotate", @"Scale", @"Translation", @"Position", @"Bounds"];
    
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

// 旋转
- (void)testRotate {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 3;
    animation.byValue = @(M_PI_4);
    //保存动画执行状态：使动画保存执行之后的状态，只要设置动画的两个属性
//    animation.removedOnCompletion = NO;//动画对象不要移除
//    animation.fillMode = kCAFillModeForwards;//保存当前的状态
    
    //2.往控件的图层添加动画
    [self.imageView.layer addAnimation:animation forKey:nil];
}

// 缩放
- (void)testScale {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 3;
    animation.toValue = @1.3;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
    
    //2.往控件的图层添加动画
    [self.imageView.layer addAnimation:animation forKey:nil];
}

// 平移
- (void)testTranslation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation"];
    animation.duration = 3;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(20, 30)];
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
    [self.imageView.layer addAnimation:animation forKey:nil];
}

// 位置平移
- (void)testPosition {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 3;
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(280, 400)];
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
    [self.imageView.layer addAnimation:animation forKey:nil];
}

// 位置平移
- (void)testBounds {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.duration = 3;
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 50, 150)];
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
    [self.imageView.layer addAnimation:animation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
