//
//  NSObject+kvo.h
//  OthersDemo
//
//  Created by dfang on 2018-6-15.
//  Copyright © 2018年 east. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (kvo)

- (void)custom_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

@end
