//
//  EPerson.m
//  UIScrollViewDemo
//
//  Created by dfang on 2017-11-13.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "EPerson.h"

@implementation EPerson

- (void)doSomething {
    if ([self.delegate respondsToSelector:@selector(meeting:)]) {
        [self.delegate meeting:self];
    } else {
        NSLog(@"%@ 在休息!", self.name);
    }
}

@end
