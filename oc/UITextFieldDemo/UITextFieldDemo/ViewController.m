//
//  ViewController.m
//  UITextFieldDemo
//
//  Created by dfang on 2018-1-15.
//  Copyright © 2018年 east. All rights reserved.
//

#import "ViewController.h"
#import "KeyboardToolbar.h"

@interface ViewController () <KeyboardToolbarDelegate>

@property (weak, nonatomic) IBOutlet UIView *fieldsContainerView;

@property (nonatomic, strong) KeyboardToolbar *toolbar;

@property (nonatomic, strong) NSArray *fields;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *fieldsM = [NSMutableArray array];
    for (UIView *subView in self.fieldsContainerView.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *tf = (UITextField *)subView;
            tf.inputAccessoryView = self.toolbar;
            [fieldsM addObject:tf];
        }
    }
    _fields = fieldsM;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (KeyboardToolbar *)toolbar {
    if (_toolbar == nil) {
        _toolbar = [KeyboardToolbar toolbar];
        _toolbar.keyboardDelegate = self;
    }
    
    return _toolbar;
}

- (void)keyboardWillShow: (NSNotification *)notify {
    UITextField *curTF = [self currentFirstResponderField];
    CGRect keyboardFrame = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat deltaY = (self.fieldsContainerView.frame.origin.y + CGRectGetMaxY(curTF.frame)) - keyboardFrame.origin.y;
    
    NSInteger index = [self.fields indexOfObject:curTF];
    self.toolbar.previousItem.enabled = (index > 0);
    self.toolbar.nextItem.enabled = (index < self.fields.count - 1);
    
    if (deltaY > 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -deltaY);
        }];
    }
}

- (void)keyboardWillHidden: (NSNotification *)notify {
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformIdentity;
        self.toolbar.previousItem.enabled = YES;
        self.toolbar.nextItem.enabled = YES;
    }];
}

// KeyboardToolbarDelegate
- (void)keyboardClickedWithItem:(UIBarButtonItem *)item {
    UITextField *curTF = [self currentFirstResponderField];
    NSInteger index = [self.fields indexOfObject:curTF];
    
    switch (item.tag) {
        case 0: // 上一个
        {
            if (index > 0) {
                [curTF resignFirstResponder];
                [self.fields[index - 1] becomeFirstResponder];
            }
        }
            break;
        case 1: // 下一个
        {
            if (index < self.fields.count) {
                [curTF resignFirstResponder];
                [self.fields[index + 1] becomeFirstResponder];
            }
        }
            break;
        case 2: // Done
            [self.fieldsContainerView endEditing:true];
            break;
        default:
            break;
    }
}

- (UITextField *)currentFirstResponderField {
    for (UITextField *tf in self.fields) {
        if (tf.isFirstResponder) {
            return tf;
        }
    }
    return nil;
}

@end
