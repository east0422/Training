//
//  Person.m
//  OthersDemo
//
//  Created by dfang on 2018-6-13.
//  Copyright © 2018年 east. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

// Dynamically provides an implementation for a given selector for an instance method
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(eat)) { // 无参
        class_addMethod([self class], sel, (IMP)eat, "v@:");
        return YES;
    } else if (sel == @selector(eatWithObject:)) {  // 有参
        class_addMethod([self class], sel, (IMP)eatObject, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void eat(id self, SEL _cmd)
{
    NSLog(@"eat food");
//    printf("eat food\n");
}

void eatObject(id self, SEL _cmd, NSString *food) {
    // OS_ACTIVITY_MODE = disable时，NSLog不会打印到控制台
    NSLog(@"eat %@ %@ %@", food, NSStringFromClass([self class]), NSStringFromSelector(_cmd));
//    printf("eat %s %s %s\n", food.UTF8String, NSStringFromClass([self class]).UTF8String, NSStringFromSelector(_cmd).UTF8String);
}

@end
