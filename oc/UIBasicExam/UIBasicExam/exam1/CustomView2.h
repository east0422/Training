//
//  CustomView2.h
//  UIBasicExam
//
//  Created by dfang on 2017-12-22.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomView2;

@protocol CustomView2Delegate <NSObject>

@optional
- (void)fontSizeChanged:(CGFloat)fontSize;

@end

@interface CustomView2: UIView

@property (nonatomic, assign) id<CustomView2Delegate> delegate;

@end
