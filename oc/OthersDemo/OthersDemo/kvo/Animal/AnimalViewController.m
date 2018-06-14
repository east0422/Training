//
//  AnimalViewController.m
//  OthersDemo
//
//  Created by dfang on 2018-6-14.
//  Copyright © 2018年 east. All rights reserved.
//

#import "AnimalViewController.h"
#import "Animal.h"

@interface AnimalViewController ()

@property (nonatomic, strong) Animal *animal;

@end

@implementation AnimalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _animal = [[Animal alloc] init];
    // 1. 动态创建Animal子类。 2. 改变_animal对象类型为其子类型NSKVONotifying_Animal。 3. 使用子类型。
    // 查看的话在此加个断点，第一次到这里的时候Command + Q停止当前任务，再重新打开再调试就可看到_animal的isa的改变
    [_animal addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];
    _animal.name = @"小花猫";
    // 成员变量
    _animal->age = 2;
    
    NSLog(@"animal:name=%@,age=%ld", _animal.name, (long)_animal->age);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 更改背景颜色
    self.view.backgroundColor = UIColor.grayColor;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath: %@ changed", keyPath);
}

@end
