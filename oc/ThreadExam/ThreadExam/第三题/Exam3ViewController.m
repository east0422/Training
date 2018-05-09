//
//  Exam3ViewController.m
//  ThreadExam
//
//  Created by dfang on 2018-5-9.
//  Copyright © 2018年 east. All rights reserved.
//

#import "Exam3ViewController.h"

@interface Exam3ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *clockImageView;

@property (nonatomic, strong) CALayer *layerSecond;
@property (nonatomic, strong) CALayer *layerMinute;
@property (nonatomic, strong) CALayer *layerHour;

@end

@implementation Exam3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // anchorPoint属性是决定子layer上的哪个点会在position所指定的位置
    CGPoint anchorPoint = CGPointMake(0.5, 0.8);
    // position属性是决定子layer在父layer上的位置，默认为（0，0）
    CGPoint position = CGPointMake(self.clockImageView.frame.size.width/2, self.clockImageView.frame.size.height/2);
    
    // 初始化子图层
    self.layerSecond = [self createLayerWithBackgroundColor:[UIColor redColor] anchorPoint:anchorPoint position:position andBounds:CGRectMake(0, 0, 2, 100)];
    self.layerMinute = [self createLayerWithBackgroundColor:[UIColor brownColor] anchorPoint:anchorPoint position:position andBounds:CGRectMake(0, 0, 3, 80)];
    self.layerHour = [self createLayerWithBackgroundColor:[UIColor blackColor] anchorPoint:anchorPoint position:position andBounds:CGRectMake(0, 0, 5, 60)];
    
    // 为clockImageView添加子图层
    [self.clockImageView.layer addSublayer:self.layerSecond];
    [self.clockImageView.layer addSublayer:self.layerMinute];
    [self.clockImageView.layer addSublayer:self.layerHour];
    
    // 避免前一秒指针都处于0
    [self updateLayer];
    // 添加定时器更新指针
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateLayer) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

// 创建图层
- (CALayer *)createLayerWithBackgroundColor:(UIColor *)bgColor anchorPoint:(CGPoint)anchorPoint position:(CGPoint)position andBounds:(CGRect)bounds {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = bgColor.CGColor;
    layer.anchorPoint = anchorPoint;
    layer.position = position;
    layer.bounds = bounds;
    layer.cornerRadius = 5;
    
    return layer;
}

// 更新指针图层
- (void)updateLayer {
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    __weak typeof(self) weakSelf = self;
//    [queue addOperationWithBlock:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *dateComponent = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:[NSDate date]];
            
            CGFloat angleSecond = dateComponent.second * (M_PI * 2 / 60);
            CGFloat angleMinute = dateComponent.minute * (M_PI * 2 / 60) + (angleSecond / 60);
            CGFloat angleHour = dateComponent.hour * (M_PI * 2 / 12) + (angleMinute / 12);
            // 更新UI需放在主队列中
            weakSelf.layerSecond.transform = CATransform3DMakeRotation(angleSecond, 0, 0, 1);
            weakSelf.layerMinute.transform = CATransform3DMakeRotation(angleMinute, 0, 0, 1);
            weakSelf.layerHour.transform = CATransform3DMakeRotation(angleHour, 0, 0, 1);
            
        }];
//    }];
}

@end
