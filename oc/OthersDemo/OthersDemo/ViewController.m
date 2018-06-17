//
//  ViewController.m
//  OthersDemo
//
//  Created by dfang on 2018-6-13.
//  Copyright © 2018年 east. All rights reserved.
//

#import "ViewController.h"
#import "PersonViewController.h"
#import "NSURLVerifyViewController.h"
#import "AnimalViewController.h"
#import "CusKVOViewController.h"
#import "Runloop1ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Product->Edit Scheme设置OS_ACTIVITY_MODE为disable后NSLog就不会输出到控制台
//    NSLog(@"aaaa");
    
    // Warning: Attempt to present <PersonViewController: 0x139eaa240> on <ViewController: 0x139d637a0> whose view is not in the window hierarchy!
//    [self testPersonVC];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self testRunloop1];
    
//    [self testCustomKVO];
    
//    [self testAnimalVC];
    
//    [self testNSURLVerifyVC];
    
//    [self testPersonVC];
}

- (void)testRunloop1 {
    Runloop1ViewController *runloop1VC = [[Runloop1ViewController alloc] init];
    [self presentViewController:runloop1VC animated:YES completion:nil];
}

- (void)testCustomKVO {
    CusKVOViewController *cusKVOVC = [[CusKVOViewController alloc] init];
    [self presentViewController:cusKVOVC animated:YES completion:nil];
}

// 知识点，
- (void)testAnimalVC {
    AnimalViewController *animalVC = [[AnimalViewController alloc] init];
    [self presentViewController:animalVC animated:YES completion:nil];
}

// 知识点：category, method_exchangeImplementations, 替代方法中不能调用原来方法而需调用自己否则会不断调用直到内存溢出
- (void)testNSURLVerifyVC {
    NSURLVerifyViewController *nsurlVerifyVC = [[NSURLVerifyViewController alloc] init];
    [self presentViewController:nsurlVerifyVC animated:YES completion:nil];
}

// 知识点：resolveInstanceMethod, class_addMethod, objc_msgSend
- (void)testPersonVC {
    PersonViewController *personVC = [[PersonViewController alloc] init];
    [self presentViewController:personVC animated:YES completion:nil];
    
    // 如果在viewDidLoad中调用该方法则需要如下进行延迟，否则会有警告view is not in the window hierarchy并且背景色不会改变
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self presentViewController:personVC animated:YES completion:nil];
//    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
