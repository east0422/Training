//
//  CarGroup.h
//  UITableViewDemo
//
//  Created by dfang on 2017-11-22.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarGroup : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *cars;

- (instancetype)initWithDic: (NSDictionary *)dic;
+ (instancetype)carGroupWithDic: (NSDictionary *)dic;

+ (NSArray *)carGroupList;

@end
