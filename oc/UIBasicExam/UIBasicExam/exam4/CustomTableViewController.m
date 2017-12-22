//
//  CustomTableViewController.m
//  UIBasicExam
//
//  Created by dfang on 2017-12-25.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "CustomTableViewController.h"
#import "CustomDataModel.h"

@interface CustomTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *stateArray;

@end

static NSString *cellReuseId = @"customTableCellId";
@implementation CustomTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _dataArray = [CustomDataModel custDataList];
    _stateArray = [[NSMutableArray alloc] initWithCapacity:_dataArray.count];
    for (int i = 0; i <_dataArray.count; i++) {
        [_stateArray addObject:[NSNumber numberWithBool:false]];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOOL isExpand = [[self.stateArray objectAtIndex:section] boolValue];
    return isExpand ? 2: 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row == 0 ? 44 : 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseId];
    }
    
    CustomDataModel *customData = [self.dataArray objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        cell.textLabel.text = customData.titileName;
        cell.imageView.image = [UIImage imageNamed:customData.imageName];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"测试";
        cell.imageView.image = [UIImage imageNamed:@"泡妞宝典"];
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BOOL isExpand = [[self.stateArray objectAtIndex:indexPath.section] boolValue];
        [self.stateArray replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:!isExpand]];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
