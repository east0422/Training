//
//  Car.m
//  UITableViewDemo
//
//  Created by dfang on 2017-11-22.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "Car.h"

@implementation Car

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)carWithDic:(NSDictionary *)dic {
    return [[Car alloc] initWithDic:dic];
}

@end
