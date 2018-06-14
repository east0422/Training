//
//  Animal.h
//  OthersDemo
//
//  Created by dfang on 2018-6-14.
//  Copyright © 2018年 east. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject {
    @public
    NSInteger age; // 成员变量
}

// 这句话相当于定义成员变量_name并实现setter和getter方法
@property (nonatomic, copy) NSString *name;

@end
