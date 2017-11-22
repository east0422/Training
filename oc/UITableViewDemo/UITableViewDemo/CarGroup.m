//
//  CarGroup.m
//  UITableViewDemo
//
//  Created by dfang on 2017-11-22.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "CarGroup.h"
#import "Car.h"

@implementation CarGroup

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)carGroupWithDic:(NSDictionary *)dic {
    return [[CarGroup alloc] initWithDic:dic];
}

+ (NSArray *)carGroupList {
    NSArray *array = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"cars_total" ofType:@"plist"]];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        CarGroup *carGroup = [CarGroup carGroupWithDic:dic];
        NSMutableArray *carArray = [NSMutableArray arrayWithCapacity:carGroup.cars.count];
        for (NSDictionary *carDic in carGroup.cars) {
            [carArray addObject:[Car carWithDic:carDic]];
        }
        carGroup.cars = carArray;
        [list addObject:carGroup];
    }
    
    return list;
}

@end
