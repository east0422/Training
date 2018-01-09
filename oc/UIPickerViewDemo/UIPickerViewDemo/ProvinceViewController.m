//
//  ProvinceViewController.m
//  UIPickerViewDemo
//
//  Created by dfang on 2018-1-6.
//  Copyright © 2018年 east. All rights reserved.
//

#import "ProvinceViewController.h"

@interface ProvinceViewController ()

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, assign) NSInteger provinceSelected;

@end

@implementation ProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
    
    _provinceSelected = 0;
    for (int i = 0; i < self.provinces.count; i++) {
        [self pickerView:self.pickerView didSelectRow:0 inComponent:i];
    }
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:self.view.frame];
    }
    return _pickerView;
}

- (NSArray *)provinces {
    if (_provinces == nil) {
        _provinces = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"provinces" ofType:@"plist"]];
    }
    
    return _provinces;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinces.count;
    } else {
        NSDictionary *item = self.provinces[self.provinceSelected];
        NSArray *cities = [item valueForKey:@"cities"];
        return cities.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        NSDictionary *item = self.provinces[row];
        return [item valueForKey:@"name"];
    } else {
        NSDictionary *item = self.provinces[self.provinceSelected];
        NSArray *cities = [item valueForKey:@"cities"];
        return cities[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.provinceSelected = row;
        
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:0 inComponent:1 animated:true];
    }
}

@end
