//
//  NSURLVerifyViewController.m
//  OthersDemo
//
//  Created by dfang on 2018-6-14.
//  Copyright © 2018年 east. All rights reserved.
//

#import "NSURLVerifyViewController.h"

@interface NSURLVerifyViewController ()

@end

@implementation NSURLVerifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.greenColor;
    
    // 有中文需要解码否则返回的是null
    NSString *urlString = @"http://www.baidu.com/中文测试";
    
    // http://www.baidu.com/%E4%B8%AD%E6%96%87%E6%B5%8B%E8%AF%95
//    NSString *urlString = [@"http://www.baidu.com/中文测试" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    printf("request: %s\n", request.description.UTF8String);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
