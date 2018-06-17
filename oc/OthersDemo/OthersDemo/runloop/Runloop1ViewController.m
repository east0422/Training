//
//  Runloop1ViewController.m
//  OthersDemo
//
//  Created by dfang on 2018-6-17.
//  Copyright © 2018年 east. All rights reserved.
//

#import "Runloop1ViewController.h"

@interface Runloop1ViewController ()

@property (nonatomic, assign) BOOL finished;

@end

@implementation Runloop1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _finished = NO;
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            if (self.finished) {
                [timer invalidate];
                // 退出了当前线程，不会输出after runloop
                [NSThread exit];
            }
            NSLog(@"timer block %@", [NSThread currentThread]);
        }];
        NSRunLoop *curRunLoop = [NSRunLoop currentRunLoop];
        [curRunLoop addTimer:timer forMode:NSDefaultRunLoopMode];
        // runloop 实际上是一个死循环, 默认是不会执行的
        [curRunLoop run];
        // 不会输出，除非退出了上面的死循环
        NSLog(@"after runloop");
    }];
    [thread start];
    NSLog(@"thread %@", [NSThread currentThread]);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _finished = YES;
}

@end
