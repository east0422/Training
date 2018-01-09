//
//  FoodViewController.m
//  UIPickerViewDemo
//
//  Created by dfang on 2018-1-6.
//  Copyright © 2018年 east. All rights reserved.
//

#import "FoodViewController.h"

@interface FoodViewController ()

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *foods;
@property (nonatomic, strong) UILabel *fruitLabel;
@property (nonatomic, strong) UILabel *foodLabel;
@property (nonatomic, strong) UILabel *drinkLabel;
@property (nonatomic, strong) UIButton *randomButton;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation FoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.randomButton];
    [self.view addSubview:self.fruitLabel];
    [self.view addSubview:self.foodLabel];
    [self.view addSubview:self.drinkLabel];
    
    for (int i = 0; i < self.foods.count; i++) {
        [self pickerView:self.pickerView didSelectRow:0 inComponent:i];
    }
}

- (UIPickerView *)pickerView {
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    }
    
    return _pickerView;
}

- (NSArray *)foods {
    if (_foods == nil) {
        NSString *foodFile = [[NSBundle mainBundle] pathForResource:@"foods" ofType:@"plist"];
        _foods = [NSArray arrayWithContentsOfFile:foodFile];
    }
    return _foods;
}

- (UILabel *)fruitLabel {
    if (_fruitLabel == nil) {
        _fruitLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 310, self.view.frame.size.width, 50)];
        _fruitLabel.text = @"水果：";
    }
    return _fruitLabel;
}

- (UILabel *)foodLabel {
    if (_foodLabel == nil) {
        _foodLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 360, self.view.frame.size.width, 50)];
        _foodLabel.text = @"主食：";
    }
    return _foodLabel;
}

- (UILabel *)drinkLabel {
    if (_drinkLabel == nil) {
        _drinkLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 410, self.view.frame.size.width, 50)];
        _drinkLabel.text = @"饮料：";
    }
    return _drinkLabel;
}

- (UIButton *)randomButton {
    if (_randomButton == nil) {
        _randomButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 100, 50)];
        [_randomButton setTitle:@"随机" forState:UIControlStateNormal];
        [_randomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_randomButton addTarget:self action:@selector(randomBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _randomButton;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 50)];
        _titleLabel.text = @"点菜系统";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return self.foods.count;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *items = self.foods[component];
    return items.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *items = self.foods[component];
    return  items[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSArray *items = self.foods[component];
    if (component == 0) {
        self.fruitLabel.text = [NSString stringWithFormat:@"水果：%@",  items[row]];
    } else if (component == 1) {
        self.foodLabel.text = [NSString stringWithFormat:@"主食：%@",  items[row]];
    } else if (component == 2) {
        self.drinkLabel.text = [NSString stringWithFormat:@"饮料：%@",  items[row]];
    }
}

- (void)randomBtnClicked {
    for (int i = 0; i < self.foods.count; i++) {
        NSArray *items = self.foods[i];
        
        NSInteger oldSelected = [self.pickerView selectedRowInComponent:i];
        NSInteger randomSelected = arc4random_uniform(items.count);
        while (randomSelected == oldSelected) {
           randomSelected = arc4random_uniform(items.count);
        }
        
        [self.pickerView selectRow:randomSelected inComponent:i animated:true];
        [self pickerView:self.pickerView didSelectRow:randomSelected inComponent:i];
    }
}

@end
