//
//  PersonViewController.m
//  OthersDemo
//
//  Created by dfang on 2018-6-14.
//  Copyright © 2018年 east. All rights reserved.
//

#import "PersonViewController.h"
// 头文件中定义eat方法，在m文件中使用runtime添加实现
#import "Person.h"
#import <objc/message.h>

@interface PersonViewController ()

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.redColor;
    
    Person *p = [[Person alloc] init];
    [p eat];
    [p eatWithObject:@"fruit"];
    // 需先将build setting中objc_msgSend值YES改为NO
    
    objc_msgSend(p, @selector(eat));
    
    // 需要先定义原型在调用，否则会发生崩溃
    void (*eatWithObject_msgsend)(id, SEL, NSString *) = (void (*)(id, SEL, NSString *))(void *)objc_msgSend;
    eatWithObject_msgsend(p, @selector(eatWithObject:), @"apple");
    
    Person *p1 = ((Person *(*)(id, SEL))(void *)objc_msgSend)((id)((Person *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));
    [p1 eatWithObject:@"rice"];
    
    Person *(*person_msgSend)(id, SEL) = (Person *(*)(id, SEL))(void *)objc_msgSend;
    Person *p2 = person_msgSend((id)person_msgSend((id)objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));
    [p2 eatWithObject:@"rice11"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
