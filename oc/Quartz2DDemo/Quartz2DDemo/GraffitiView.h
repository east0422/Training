//
//  GraffitiView.h
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-7.
//  Copyright © 2018年 east. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraffitiView : UIView

@property (nonatomic, strong) UIColor *currentColor;

// 返回，删除最后绘制的一条线
- (void)backClicked;
// 清除绘制的所有的线
- (void)clearClicked;
// 将当前视图保存到相册
- (void)saveClicked;

@end
