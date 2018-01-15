//
//  KeyboardToolbar.h
//  UITextFieldDemo
//
//  Created by dfang on 2018-1-15.
//  Copyright © 2018年 east. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyboardToolbarDelegate <NSObject>

@optional
// tag 0 -> previous, 1 -> next, 2 -> done
- (void)keyboardClickedWithItem:(UIBarButtonItem *)item;

@end

@interface KeyboardToolbar : UIToolbar

@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;

@property (nonatomic, assign) id<KeyboardToolbarDelegate> keyboardDelegate;

+ (instancetype)toolbar;

@end
