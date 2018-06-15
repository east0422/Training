//
//  NSObject+kvo.m
//  OthersDemo
//
//  Created by dfang on 2018-6-15.
//  Copyright © 2018年 east. All rights reserved.
//

#import "NSObject+kvo.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation NSObject (kvo)

- (void)custom_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    // 动态添加一个子类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [@"CusKVO_" stringByAppendingString:oldClassName];
    // 定义一个新类
    // Creates a new class and metaclass
    Class cusClass = objc_allocateClassPair([self class], newClassName.UTF8String, 0);
    // 重写setAge方法
    class_addMethod(cusClass, @selector(setAge:), (IMP)setAge, "v@:");
    // 注册创建的子类
    objc_registerClassPair(cusClass);
    // 改变isa指针
    object_setClass(self, cusClass);
    // 将观察者的属性保存到当前类里面去
    objc_setAssociatedObject(self, (__bridge const void *)@"objc", observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 相当于重写父类的方法
void setAge(id self, SEL _cmd, int age) {
    // 保存当前类
    Class class = [self class];
    // 将self的isa指针指向父类
    object_setClass(self, class_getSuperclass([self class]));
    // 调用父类的方法
    ((void (*)(id, SEL, int))(void *)objc_msgSend)(self, @selector(setAge:), age);
    // 拿出观察者
    id obsever = objc_getAssociatedObject(self, (__bridge const void *)@"objc");
    // 通知观察者
    [obsever observeValueForKeyPath:@"age" ofObject:self change:nil context:nil];
//    ((void (*)(id, SEL, NSString *, id, (NSDictionary<NSKeyValueChangeKey, id> *), (void *)))(void *)objc_msgSend)(obsever, @selector(observeValueForKeyPath:ofObject:change:context:), @"age", self, nil, nil);
    // 改为子类
    object_setClass(self, class);
}

@end
