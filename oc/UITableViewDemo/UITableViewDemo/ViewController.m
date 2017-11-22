//
//  ViewController.m
//  UITableViewDemo
//
//  Created by dfang on 2017-11-22.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "ViewController.h"
#import "CarGroup.h"
#import "Car.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview: self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    }
    return _tableView;
}

- (NSArray *)datas {
    if (nil == _datas) {
        _datas = [CarGroup carGroupList];
    }
    return _datas;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CarGroup *carGroup = self.datas[section];
    if (nil == carGroup) {
        return 0;
    }
    return carGroup.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseid = @"cargroupreuseid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid];
    
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseid];
    }
    
    cell.separatorInset = UIEdgeInsetsZero;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    CarGroup *carGroup = self.datas[indexPath.section];
    Car *car = carGroup.cars[indexPath.row];
    cell.textLabel.text = car.name;
    cell.imageView.image = [UIImage imageNamed:car.icon];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CarGroup *carGroup = self.datas[section];
    return carGroup.title;
}

@end
