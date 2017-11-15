//
//  EPerson.h
//  UIScrollViewDemo
//
//  Created by dfang on 2017-11-13.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EPerson;

@protocol EPersonDelegate <NSObject>

@optional
- (void)meeting:(EPerson *)person;

@end

@interface EPerson : NSObject

@property (nonatomic, assign) NSString *name;

@property (nonatomic, assign) id<EPersonDelegate> delegate;

- (void)doSomething;

@end
