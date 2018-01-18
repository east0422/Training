//
//  AddContactViewController.m
//  AddressBookDemo
//
//  Created by dfang on 2018-1-17.
//  Copyright © 2018年 east. All rights reserved.
//

#import "AddContactViewController.h"

@interface AddContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)textChanged {
    self.saveBtn.enabled = (self.nameField.text.length > 0 && self.phoneField.text.length > 0);
}

- (IBAction)saveBtnClicked {
    if ([self.delegate respondsToSelector:@selector(addContactViewControllerDidSaveContact:)]) {
        Contact *contact = [[Contact alloc] init];
        contact.name = self.nameField.text;
        contact.phone = self.phoneField.text;
        [self.delegate addContactViewControllerDidSaveContact:contact];
    }
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
}

@end
