//
//  FlagViewController.m
//  UIPickerViewDemo
//
//  Created by dfang on 2018-1-6.
//  Copyright © 2018年 east. All rights reserved.
//

#import "FlagViewController.h"
#import "FlagView.h"

@interface FlagViewController ()

@property (nonatomic, strong) UIPickerView *pickerview;
@property (nonatomic, strong) NSArray *flags;

@end

@implementation FlagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.pickerview.delegate = self;
    self.pickerview.dataSource = self;
    [self.view addSubview:self.pickerview];
    
}

- (UIPickerView *)pickerview {
    if (_pickerview == nil) {
        _pickerview = [[UIPickerView alloc] initWithFrame:self.view.frame];
    }
    
    return _pickerview;
}

- (NSArray *)flags {
    if (_flags == nil) {
        _flags = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"flags" ofType:@"plist"]];
    }
    
    return _flags;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.flags.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    FlagView *flagView = (FlagView *)view;
    if (flagView == nil) {
        flagView = [[FlagView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    }
    
    NSDictionary *item = self.flags[row];
    flagView.nameLabel.text = [item valueForKey:@"name"];
    flagView.iconImageView.image = [UIImage imageNamed:[item valueForKey:@"icon"]];
    
    return flagView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 100;
}

@end
