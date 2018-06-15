//
//  CusKVOViewController.m
//  OthersDemo
//
//  Created by dfang on 2018-6-15.
//  Copyright © 2018年 east. All rights reserved.
//

#import "CusKVOViewController.h"
#import "CusPerson.h"
#import "NSObject+kvo.h"

@interface CusKVOViewController ()

@property (nonatomic, strong) CusPerson *cusPerson;

@end

@implementation CusKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cusPerson = [[CusPerson alloc] init];
    // <CusPerson: 0x101352220>
    [_cusPerson  custom_addObserver:self forKeyPath:@"age" options:(NSKeyValueObservingOptionNew) context:nil];
    // <CusKVO_CusPerson: 0x101352220>
    _cusPerson.age = 18;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@ changed", keyPath);
}

@end
