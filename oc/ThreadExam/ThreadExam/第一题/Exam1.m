//
//  Exam1.m
//  ThreadExam
//
//  Created by dfang on 2018-5-9.
//  Copyright © 2018年 east. All rights reserved.
//

#import "Exam1.h"
@implementation Exam1

+ (void)start {
    [[self alloc] printABC];
}

- (void)printABC {
    NSArray *threadNames = @[@"A", @"B", @"C"];
    NSConditionLock *conditionLock = [[NSConditionLock alloc] initWithCondition:0];
    
    for (int i = 0; i < threadNames.count; i++) {
        NSThread *thread = [[NSThread alloc] initWithBlock:^{
            for (int j = 0; j < 10; j++) {
                [conditionLock lockWhenCondition:i];
                NSLog(@"%d %@", j, [NSThread currentThread].name);
                [conditionLock unlockWithCondition:(i+1)%threadNames.count];
            }
        }];
        thread.name = threadNames[i];
        [thread start];
    }
    
}

@end
