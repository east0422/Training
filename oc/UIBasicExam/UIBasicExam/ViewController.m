//
//  ViewController.m
//  UIBasicExam
//
//  Created by dfang on 2017-12-21.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"
#import "CustomView2.h"
#import "CustomNavigationBar.h"
#import "CustomScrollviewController.h"
#import "CustomTableViewController.h"
#import "Exam5ViewController.h"

@interface ViewController () <CustomView2Delegate>

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    // exam1 CustomView
    /*
    CustomView *customView = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [self.view addSubview: customView];
    */
    
    // exam1 CustomView2 and delegate
    /*
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, screenSize.width, 60)];
    _titleLabel.textAlignment =NSTextAlignmentCenter;
    _titleLabel.text = @"测试文字";
    _titleLabel.font = [UIFont systemFontOfSize:8];
    _titleLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_titleLabel];
    
    CustomView2 *customView2 = [[CustomView2 alloc] initWithFrame:CGRectMake(0, 110, screenSize.width, screenSize.height)];
    customView2.delegate = self;
    [self.view addSubview:customView2];
     */
    
    // exam2 CustomNavigationBar
    /*
    NSArray *array = @[@"新闻", @"最新动态", @"黑马", @"测试一", @"测试二"];
    CustomNavigationBar *customBar = [[CustomNavigationBar alloc] initWithFrame:CGRectMake(0, 50, screenSize.width, 50)];
    customBar.dataArray = array;
    [self.view addSubview:customBar];
    */
    
    // exam3 CustomScrollviewController
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        CustomScrollviewController *exam3 = [[CustomScrollviewController alloc] init];
        [self presentViewController:exam3 animated:YES completion:nil];
    });
     */
    
    // exam4 CustomTableViewController
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        CustomTableViewController *exam4 = [[CustomTableViewController alloc] init];
        [self presentViewController:exam4 animated:YES completion:nil];
    });
     */
    
    // exam5 Exam5ViewController
    dispatch_async(dispatch_get_main_queue(), ^{
        Exam5ViewController *exam5 = [[Exam5ViewController alloc] init];
        [self presentViewController:exam5 animated:YES completion:nil];
    });
}

#pragma mark -- customView2 delegate
- (void)fontSizeChanged:(CGFloat)fontSize {
    _titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
