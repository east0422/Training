//
//  LockView.h
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-7.
//  Copyright © 2018年 east. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LockViewDelegate<NSObject>

@optional
- (void)unlockWithPassword:(NSString *)password;

@end

@interface LockView : UIView

@property (nonatomic, assign) id<LockViewDelegate> delegate;

@end
