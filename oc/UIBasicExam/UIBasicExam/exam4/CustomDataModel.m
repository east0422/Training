//
//  CustomDataModel.m
//  UIBasicExam
//
//  Created by dfang on 2017-12-25.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "CustomDataModel.h"

@implementation CustomDataModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)customDataModelWithDic:(NSDictionary *)dic {
    return [[CustomDataModel alloc] initWithDic:dic];
}

+ (NSMutableArray *)custDataList {
    NSArray *array = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"]];
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        [list addObject:[CustomDataModel customDataModelWithDic:dic]];
    }
    
    return list;
}


@end
