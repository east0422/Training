//
//  ViewController.m
//  ThreadExam
//
//  Created by dfang on 2018-5-9.
//  Copyright © 2018年 east. All rights reserved.
//

#import "ViewController.h"
#import "Exam1.h"
#import "Exam2ViewController.h"
#import "Exam3ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [Exam1 start];
    
//    Exam2ViewController *exam2 = [[Exam2ViewController alloc] init];
//    exam2.view.backgroundColor = [UIColor whiteColor];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self presentViewController:exam2 animated:true completion:nil];
//    });
    
    Exam3ViewController *exam3 = [[Exam3ViewController alloc] init];
    exam3.view.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:exam3 animated:true completion:nil];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
