//
//  EditContactViewController.m
//  AddressBookDemo
//
//  Created by dfang on 2018-1-17.
//  Copyright © 2018年 east. All rights reserved.
//

#import "EditContactViewController.h"

@interface EditContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation EditContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameField.text = self.contact.name;
    self.phoneField.text = self.contact.phone;
}

- (IBAction)editItemClicked:(UIBarButtonItem *)sender {
    self.nameField.enabled = !self.nameField.isEnabled;
    self.phoneField.enabled = !self.phoneField.isEnabled;
    self.saveBtn.hidden = !self.saveBtn.isHidden;
    
    if (self.saveBtn.isHidden) {
        sender.title = @"取消";
    } else {
        sender.title = @"编辑";
    }
}

- (IBAction)saveBtnClicked {
    if ([self.delegate respondsToSelector:@selector(editContactViewControllerDidSaveContact:)]) {
        self.contact.name = self.nameField.text;
        self.contact.phone = self.phoneField.text;
        [self.delegate editContactViewControllerDidSaveContact:self.contact];
    }
}

- (IBAction)textChanged {
    self.saveBtn.enabled = (self.nameField.text.length > 0 && self.phoneField.text.length > 0);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

// UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
