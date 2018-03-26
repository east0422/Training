//
//  TransitionAnimationViewController.m
//  AnimationDemo
//
//  Created by dfang on 2018-3-27.
//  Copyright © 2018年 east. All rights reserved.
//

#import "TransitionAnimationViewController.h"

@interface TransitionAnimationViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) int curIndex;

@end

@implementation TransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"转场动画演示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _curIndex = 0;
    [self.view addSubview:self.imageView];
    
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _imageView.image = [UIImage imageNamed:self.images[self.curIndex]];
    }
    return _imageView;
}

- (NSArray *)images {
    if (_images == nil) {
        _images = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    }
    return _images;
}

// 上一张图片
- (void)previousImage {
    if (self.curIndex > 0) {
        self.curIndex--;
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromRight;
        animation.duration = 3;
        self.imageView.image = [UIImage imageNamed:self.images[self.curIndex]];
        [self.imageView.layer addAnimation:animation forKey:nil];
    } else {
        NSLog(@"已是第一张了！");
    }
}

// 下一张图片
- (void)nextImage {
    if (self.curIndex < self.images.count) {
        self.curIndex++;
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromLeft;
        animation.duration = 3;
        self.imageView.image = [UIImage imageNamed:self.images[self.curIndex]];
        [self.imageView.layer addAnimation:animation forKey:nil];
    } else {
        NSLog(@"已是最后一张了！");
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint touchPoint = [touches.anyObject locationInView:self.view];
    if (touchPoint.x < self.view.frame.size.width / 2) {
        [self previousImage];
    } else {
        [self nextImage];
    }
}

@end
