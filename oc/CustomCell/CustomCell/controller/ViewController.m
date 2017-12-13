//
//  ViewController.m
//  CustomCell
//
//  Created by dfang on 2017-12-12.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

#import "ViewController.h"
#import "MicroBlogCell.h"
#import "MicroBlogHeaderView.h"
#import "MicroBlogFooterView.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, MicroBlogFooterViewDelegate>

@property (nonatomic, strong) NSArray *microBlogList;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.tableHeaderView = [[MicroBlogHeaderView alloc] initWithHeaderHeight:140];
    MicroBlogFooterView *footerView = [[MicroBlogFooterView alloc] initWithFooterHeight:34];
    footerView.delegate = self;
    self.tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)microBlogList {
    if (!_microBlogList) {
        _microBlogList = [MicroBlog microBlogList];
    }
    return _microBlogList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    }
    return _tableView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MicroBlogCell *cell = [MicroBlogCell microBlogCellWithTableView:tableView andCellStyle:UITableViewCellStyleDefault];
    cell.microBlog = self.microBlogList[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.microBlogList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MicroBlog *microBlog = self.microBlogList[indexPath.row];
    return microBlog.rowHeight;
}

#pragma mark - method for MicroBlogFooterViewDelegate
- (void)footerViewDidClickedLoadMoreBtn:(MicroBlogFooterView *)microBlogFooterView {
    NSLog(@"call footerViewDidClickedLoadMoreBtn");
}

@end
