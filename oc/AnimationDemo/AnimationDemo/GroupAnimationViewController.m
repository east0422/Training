//
//  GroupAnimationViewController.m
//  AnimationDemo
//
//  Created by dfang on 2018-3-27.
//  Copyright © 2018年 east. All rights reserved.
//

#import "GroupAnimationViewController.h"

@interface GroupAnimationViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation GroupAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"组动画演示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 40)];
    [button setTitle:@"开始演示" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.borderWidth = 1.3;
    button.layer.borderColor = [UIColor grayColor].CGColor;
    [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImage *image = [UIImage imageNamed:@"image"];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - image.size.width)/2, 100, image.size.width, image.size.height)];
        _imageView.image = image;
    }
    return _imageView;
}

- (void)btnClicked {
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    // 1. 平移动画
    CABasicAnimation *positionAni = [CABasicAnimation animation];
    positionAni.keyPath = @"position";
    positionAni.toValue = [NSValue valueWithCGPoint:CGPointMake(250, 250)];
    
    // 2. 旋转效果
    CABasicAnimation *rotationAni = [CABasicAnimation animation];
    rotationAni.keyPath = @"transform.rotation";
    rotationAni.toValue = @(M_PI_2);
    
    // 3. 缩放效果
    CABasicAnimation *scaleAni = [CABasicAnimation animation];
    scaleAni.keyPath = @"transform.scale";
    scaleAni.toValue = @(0.5);
    
    // 4. 透明度
    CABasicAnimation *opacityAni = [CABasicAnimation animation];
    opacityAni.keyPath = @"opacity";
    opacityAni.fromValue = @1;
    opacityAni.toValue = @0.3;
    
    group.duration = 3;
    group.animations = @[positionAni, rotationAni, scaleAni, opacityAni];
    
    // 把组动画添加到图层上
    [self.imageView.layer addAnimation:group forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
