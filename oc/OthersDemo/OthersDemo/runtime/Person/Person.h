//
//  Person.h
//  OthersDemo
//
//  Created by dfang on 2018-6-13.
//  Copyright © 2018年 east. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

// 只定义，在m文件中使用runtime动态添加实现方法
- (void)eat;

// 有参函数
- (void)eatWithObject:(NSString *)food;

@end
