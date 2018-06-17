//
//  main.m
//  OthersDemo
//
//  Created by dfang on 2018-6-13.
//  Copyright © 2018年 east. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        NSLog(@"aaaaaaa");
        int aa = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        // 不会输出到控制台，上面UIApplicationMain会进入runloop
//        NSLog(@"bbbbbbb");
        return aa;
    }
}
