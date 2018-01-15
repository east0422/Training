//
//  KeyboardToolbar.m
//  UITextFieldDemo
//
//  Created by dfang on 2018-1-15.
//  Copyright © 2018年 east. All rights reserved.
//

#import "KeyboardToolbar.h"

@implementation KeyboardToolbar

+ (instancetype)toolbar {
    return [[[NSBundle mainBundle] loadNibNamed:@"KeyboardToolbar" owner:self options:nil] lastObject];
}

- (IBAction)itemClicked:(UIBarButtonItem *)item {
    if ([self.keyboardDelegate respondsToSelector:@selector(keyboardClickedWithItem:)]) {
        [self.keyboardDelegate keyboardClickedWithItem:item];
    }
}

@end
