//
//  Car.h
//  UITableViewDemo
//
//  Created by dfang on 2017-11-22.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

- (instancetype)initWithDic: (NSDictionary *)dic;
+ (instancetype)carWithDic: (NSDictionary *)dic;

@end
