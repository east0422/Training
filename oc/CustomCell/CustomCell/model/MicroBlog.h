//
//  MicroBlog.h
//  CustomCell
//
//  Created by dfang on 2017-12-13.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface MicroBlog : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picture;

@property (nonatomic, assign, getter=isVip) BOOL vip;

@property (nonatomic, assign, readonly) CGFloat rowHeight;

// subviews frame
@property (nonatomic, assign, readonly) CGRect textFrame;
@property (nonatomic, assign, readonly) CGRect iconFrame;
@property (nonatomic, assign, readonly) CGRect nameFrame;
@property (nonatomic, assign, readonly) CGRect pictureFrame;
@property (nonatomic, assign, readonly) CGRect vipFrame;

+ (instancetype)microBlogWithDic: (NSDictionary *)dic;

- (instancetype)initWithDic: (NSDictionary *)dic;

+ (NSArray *)microBlogList;

@end
