//
//  NSURL+Verify.m
//  OthersDemo
//
//  Created by dfang on 2018-6-14.
//  Copyright © 2018年 east. All rights reserved.
//

#import "NSURL+Verify.h"
#import <objc/runtime.h>

@implementation NSURL (Verify)

// load方法先加载
+ (void)load {
    Method originMethod = class_getClassMethod(self, @selector(URLWithString:));
    Method replacedMethod = class_getClassMethod(self, @selector(Verify_URLWithString:));
    // 交换两个方法实现
    method_exchangeImplementations(originMethod, replacedMethod);
}

+ (instancetype)Verify_URLWithString:(NSString *)URLString {
    // 注意：如果使用[NSURL URLWithString:URLString];会一直调用直到内存溢出
    NSURL *url = [NSURL Verify_URLWithString:URLString];
    if (url == nil) {
        printf("url 为 nil\n");
    }
    return url;
}

@end
