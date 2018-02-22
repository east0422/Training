//
//  ViewController.m
//  CALayerDemo
//
//  Created by dfang on 2018-2-22.
//  Copyright © 2018年 east. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Crop.h"
#import "CustomLayer.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *cusView;
@property (nonatomic, weak) CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 测试基本属性
//    [self testBasicAttr];
    
    // 测试裁剪图片设置圆角阴影
//    [self testCropImage];
    
    // 测试图层转换
//    [self.view addSubview:self.cusView];
    
    // 测试图层位置和锚点
//    [self testPostionAnchor];
    
    // 测试自定义layer
//    [self testCustomLayer];
    
    // 隐式动画，只有非根层(控件的layer属性的子层sublayers)才有隐式动画，根层(控件的layer属性)没有隐式动画
    CALayer *layer = [CALayer layer];
    layer.contents = (id)[UIImage imageNamed:@"papa"].CGImage;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.position = CGPointMake(150, 250);
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    [self.view.layer addSublayer:layer];
    self.layer = layer;
}

- (UIView *)cusView {
    if (_cusView == nil) {
        _cusView = [[UIView alloc] initWithFrame:CGRectMake(80, 80, 150, 150)];
        _cusView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"papa"].CGImage);
    }
    return _cusView;
}

#pragma 图层基本属性测试
- (void)testBasicAttr {
    UIView *cusView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 150)];
    // 背景颜色
    cusView.backgroundColor = [UIColor redColor];
    
    CALayer *layer = [CALayer layer];
    // 图层尺寸，bounds设置当前视图左上角(默认为(0,0))相对子视图的坐标点,注意layer默认position为(0,0), anchorPoint为(0.5,0.5)
    layer.bounds = CGRectMake(0, 0, 150, 150);
    // 图层透明度
    layer.opacity = 0.5;
    // 图层背景颜色
    layer.backgroundColor = [UIColor greenColor].CGColor;
    
    layer.borderColor = [UIColor blackColor].CGColor;
    layer.borderWidth = 2;
    layer.cornerRadius = 10;
    // 剪掉圆角周边
//    layer.masksToBounds = YES;
    
    // 阴影
    layer.shadowColor = [UIColor blueColor].CGColor;
    layer.shadowOpacity = 0.5;
    // 设置阴影偏移位置，默认为(0,0)
    layer.shadowOffset = CGSizeMake(30, 30);
    layer.shadowRadius = 10;
    layer.contents = (id)([UIImage imageNamed:@"papa"].CGImage);
    
    // 若想圆角周边和阴影同时存在则使用圆角图片再设置阴影即可
    
    [cusView.layer addSublayer:layer];
    [self.view addSubview:cusView];
}

#pragma 裁剪圆角图片并加阴影
- (void)testCropImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 80, 150, 150)];
    UIImage *cropImage = [UIImage cropImageWith:@"papa" cornerRadius:10 borderWidth:2 borderColor:[UIColor blueColor]];
    // 设置圆角图片
    imageView.image = cropImage;
    // 设置阴影
    imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    // 阴影偏移位置，默认为(0,0)
    imageView.layer.shadowOffset = CGSizeMake(30, 30);
    imageView.layer.shadowOpacity = 0.7;
    imageView.layer.shadowRadius = 15;
    
    [self.view addSubview:imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CATransform3D transform = self.cusView.layer.transform;
    // 缩放
//    self.cusView.layer.transform = CATransform3DScale(transform, 1.1, 1.1, 1);
    // 旋转
//    self.cusView.layer.transform = CATransform3DRotate(transform, M_PI_4 / 4, 1, 1, 1);
    // 平移
//    self.cusView.layer.transform = CATransform3DTranslate(transform, 10, 10, 0);
    

    // kvc forKey
//    [self.cusView.layer setValue:[NSValue valueWithCATransform3D:CATransform3DScale(transform, 1.1, 1.1, 1)] forKey:@"transform"];
//     [self.cusView.layer setValue:[NSValue valueWithCGRect:CGRectMake(0, 0, 200, 300)] forKey:@"bounds"];
    
    
    // kvc forKeyPath
//    [self.cusView.layer setValue:@(1.5) forKeyPath:@"transform.scale.x"];
//    [self.cusView.layer setValue:@(M_PI_4) forKeyPath:@"transform.rotation.y"];
//    [self.cusView.layer setValue:@(-20) forKeyPath:@"transform.translation.x"];
//    [self.cusView.layer setValue:[NSValue valueWithCGPoint:CGPointMake(10, 20)] forKeyPath:@"transform.translation"];
    
    // 隐式动画
    [CATransaction begin];
    [CATransaction setAnimationDuration:5];
    self.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 1);
    [CATransaction commit];
}

#pragma 图层位置和锚点
- (void)testPostionAnchor {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    //图层的透明度
    layer.opacity = 0.5;
    
    // 设置位置
    layer.position = CGPointMake(100, 100);
    // 设置锚点
    layer.anchorPoint = CGPointMake(0, 0.5);
    
    //然后添加到控制器的view的图层
    [self.view.layer addSublayer:layer];
}

#pragma 自定义图层
- (void)testCustomLayer {
    CustomLayer *layer = [CustomLayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 150, 150);
    
    // 自定义的图层在drawInContext绘制的东西若要显示则必须手动调用setNeedsDisplay
    [layer setNeedsDisplay];
    
    layer.position = CGPointMake(150, 150);
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    [self.view.layer addSublayer:layer];
}

@end
