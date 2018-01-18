//
//  LoginViewController.m
//  AddressBookDemo
//
//  Created by dfang on 2018-1-17.
//  Copyright © 2018年 east. All rights reserved.
//

#import "LoginViewController.h"
#import "ContactsViewController.h"

#define usernameKey @"username"
#define passwordKey @"password"
#define rememberPwdKey @"rememberPwd"
#define autoLoginKey @"autoLogin"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPwdSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.usernameField.text = [defaults objectForKey:usernameKey];
    self.rememberPwdSwitch.on = [defaults boolForKey:rememberPwdKey];
    self.autoLoginSwitch.on = [defaults boolForKey:autoLoginKey];
    
    if (self.rememberPwdSwitch.isOn) {
        self.passwordField.text = [defaults objectForKey:passwordKey];
    }
    
    [self textChanged];
    
    if (self.autoLoginSwitch.isOn) {
        [self loginClicked];
    }
   
}

- (IBAction)textChanged {
    BOOL isBtnEnabled = self.usernameField.text.length > 0 && self.passwordField.text.length > 0;
    self.loginBtn.enabled = isBtnEnabled;
    self.registerBtn.enabled = isBtnEnabled;
}

- (IBAction)loginClicked {
    if ([self.usernameField.text isEqualToString:@"east"] && [self.passwordField.text isEqualToString:@"1234"]) {
        [self performSegueWithIdentifier:@"toContactsSegue" sender:nil];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.usernameField.text forKey:usernameKey];
        if (self.rememberPwdSwitch.isOn) {
            [defaults setObject:self.passwordField.text forKey:passwordKey];
        }
        [defaults synchronize];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录失败" message:@"您输入的用户名或密码错误！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        });
    }
}

- (IBAction)registerClicked {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注册新用户" message:@"正在完善中，敬请期待！" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertController dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)saveSwitchToPreference {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.rememberPwdSwitch.isOn forKey:rememberPwdKey];
    [defaults setBool:self.autoLoginSwitch.isOn forKey:autoLoginKey];
    [defaults synchronize];
}

- (IBAction)rememberPwdSwitchChanged {
    if (!self.rememberPwdSwitch.isOn && self.autoLoginSwitch.isOn) {
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
    
    [self saveSwitchToPreference];
}

- (IBAction)autoLoginSwitchChanged {
    if(self.autoLoginSwitch.isOn && !self.rememberPwdSwitch.isOn) {
        [self.rememberPwdSwitch setOn:YES animated:YES];
    }
    [self saveSwitchToPreference];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destVC = segue.destinationViewController;
    if ([destVC isKindOfClass:[ContactsViewController class]]) {
        ContactsViewController *contactsVC = destVC;
        contactsVC.name = self.usernameField.text;
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
    // Dispose of any resources that can be recreated.
}

@end
