//
//  ViewController.m
//  Quartz2DDemo
//
//  Created by dfang on 2018-1-26.
//  Copyright © 2018年 east. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import "ProgressCircle.h"
#import "HuangView.h"
#import "PieView.h"
#import "BalloonView.h"
#import "WaterImageView.h"
#import "GraffitiView.h"
#import "LockView.h"

@interface ViewController () <LockViewDelegate>

@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) ProgressCircle *progressCircle;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) GraffitiView *graffiti;
@property (nonatomic, strong) UIButton *colorBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // CustomView
//    CustomView *customView = [[CustomView alloc] initWithFrame:self.view.frame];
//    customView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:customView];
    
    // ProgressCircle
//    [self.view addSubview:self.progressCircle];
//    [self.view addSubview:self.slider];
    
    // HuangView
//    HuangView *huang = [[HuangView alloc] initWithFrame:self.view.frame];
//    huang.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:huang];
    
    // PieView
//    PieView *pie = [[PieView alloc] initWithFrame:self.view.frame];
//    pie.backgroundColor = [UIColor whiteColor];
//    pie.sections = @[@20, @50, @30];
//    pie.sectionColors = @[[UIColor yellowColor], [UIColor greenColor], [UIColor blueColor]];
//    [self.view addSubview:pie];
    
    // BalloonView
//    BalloonView *balloon = [[BalloonView alloc] initWithFrame:self.view.frame];
//    balloon.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:balloon];

    // WaterImageView
//    _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
//    _imageView.image = [UIImage imageNamed:@"scene"];
//    [self.view addSubview:_imageView];
    
    // GraffitiView
//    [self testGraffitiView];
    
    // LockView
    LockView *lock = [[LockView alloc] initWithFrame:self.view.frame];
    lock.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gesture_bg"]];
    lock.delegate = self;
    lock.center = self.view.center;
    [self.view addSubview:lock];
}

// test for ProgressCircle
- (UISlider *)slider {
    if (_slider == nil) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 200, 200, 30)];
        [_slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (ProgressCircle *)progressCircle {
    if (_progressCircle == nil) {
        _progressCircle = [[ProgressCircle alloc] initWithFrame:CGRectMake(50, 50, 240, 128)];
        _progressCircle.backgroundColor = [UIColor whiteColor];
    }
    return  _progressCircle;
}

- (void)sliderChanged:(UISlider *)sender {
    self.progressCircle.progress = sender.value;
}

// test WaterImageView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIImage *newImage = [WaterImageView waterImageWithBgImageName:@"scene" waterImageName:@"logo" scale:2];
    self.imageView.image = newImage;
}

// test GraffitiView
- (void)testGraffitiView {
    CGFloat padding = 30;
    CGFloat marginTop = 50;
    CGFloat btnWidth = (self.view.frame.size.width - padding * 4) / 3;
    CGFloat btnHeight = 40;
    self.graffiti = [[GraffitiView alloc] initWithFrame:CGRectMake(10, marginTop + btnHeight + 20, self.view.frame.size.width - 20, 350)];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(padding, marginTop, btnWidth, btnHeight)];
    backBtn.backgroundColor = [UIColor cyanColor];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self.graffiti action:@selector(backClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(padding + (btnWidth + padding), marginTop, btnWidth, btnHeight)];
    clearBtn.backgroundColor = [UIColor cyanColor];
    [clearBtn setTitle:@"清除" forState:UIControlStateNormal];
    [clearBtn addTarget:self.graffiti action:@selector(clearClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearBtn];
    
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(padding + (btnWidth + padding) * 2, marginTop, btnWidth, btnHeight)];
    saveBtn.backgroundColor = [UIColor cyanColor];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self.graffiti action:@selector(saveClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    self.graffiti.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.graffiti];
    
    self.colorBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - btnWidth * 2)/2, CGRectGetMaxY(self.graffiti.frame) + 10, btnWidth * 2, btnHeight)];
    self.colorBtn.backgroundColor = [UIColor blackColor];
    [self.colorBtn setTitle:@"随机颜色" forState:UIControlStateNormal];
    [self.colorBtn addTarget:self action:@selector(colorBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.colorBtn];
}

    // test for GraffitiView
- (void)colorBtnClicked {
    UIColor *color = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    self.graffiti.currentColor = color;
    self.colorBtn.backgroundColor = color;
}

    // LockViewDelegate
- (void)unlockWithPassword:(NSString *)password {
    NSLog(@"password:%@", password);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
