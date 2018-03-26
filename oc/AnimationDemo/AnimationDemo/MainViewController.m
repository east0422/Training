//
//  MainViewController.m
//  AnimationDemo
//
//  Created by dfang on 2018-3-27.
//  Copyright © 2018年 east. All rights reserved.
//

#import "MainViewController.h"
#import "BasicAnimationViewController.h"
#import "KeyFrameAnimationViewController.h"
#import "TransitionAnimationViewController.h"
#import "GroupAnimationViewController.h"
#import "SummaryAnimationViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // method 1: assign viewcontrollers
    [self addViewControllers];
    
    // method2: addchildviewcontroller
    [self addChildViewController:[[BasicAnimationViewController alloc] init] withTitle:@"基本动画" andImageName:@"TabBar1"];
    [self addChildViewController:[[KeyFrameAnimationViewController alloc] init] withTitle:@"帧动画" andImageName:@"TabBar2"];
    [self addChildViewController:[[TransitionAnimationViewController alloc] init] withTitle:@"转场动画" andImageName:@"TabBar3"];
    [self addChildViewController:[[GroupAnimationViewController alloc] init] withTitle:@"组动画" andImageName:@"TabBar4"];
    [self addChildViewController:[[SummaryAnimationViewController alloc] init] withTitle:@"动画总结" andImageName:@"TabBar5"];
}

// assign viewcontrollers
- (void)addViewControllers {
    BasicAnimationViewController *basicAni = [[BasicAnimationViewController alloc] init];
    basicAni.tabBarItem.title = @"基本动画";
    basicAni.navigationItem.title = @"基本动画演示";
    basicAni.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    basicAni.tabBarItem.image = [[UIImage imageNamed:@"TabBar1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    basicAni.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabBar1Sel"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    KeyFrameAnimationViewController *keyframAni = [[KeyFrameAnimationViewController alloc] init];
    keyframAni.tabBarItem.title = @"帧动画";
    keyframAni.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    keyframAni.tabBarItem.image = [[UIImage imageNamed:@"TabBar2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    keyframAni.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabBar2Sel"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    TransitionAnimationViewController *transiAni = [[TransitionAnimationViewController alloc] init];
    transiAni.tabBarItem.title = @"转场动画";
    transiAni.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    transiAni.tabBarItem.image = [[UIImage imageNamed:@"TabBar3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    transiAni.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabBar3Sel"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    GroupAnimationViewController *groupAni = [[GroupAnimationViewController alloc] init];
    groupAni.tabBarItem.title = @"组动画";
    groupAni.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    groupAni.tabBarItem.image = [[UIImage imageNamed:@"TabBar4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    groupAni.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabBar4Sel"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    SummaryAnimationViewController *summaryAni = [[SummaryAnimationViewController alloc] init];
    summaryAni.tabBarItem.title = @"动画总结";
    summaryAni.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    summaryAni.tabBarItem.image = [[UIImage imageNamed:@"TabBar5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    summaryAni.tabBarItem.selectedImage = [[UIImage imageNamed:@"TabBar5Sel"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    
    self.viewControllers = @[[[UINavigationController alloc] initWithRootViewController:basicAni],
                             [[UINavigationController alloc] initWithRootViewController:keyframAni],
                             [[UINavigationController alloc] initWithRootViewController:transiAni],
                             [[UINavigationController alloc] initWithRootViewController:groupAni],
                             [[UINavigationController alloc] initWithRootViewController:summaryAni]
                             ];
}

// add childviewcontroller
- (void)addChildViewController:(UIViewController *)childController withTitle: (NSString *)title andImageName: (NSString *)imageName {
    childController.tabBarItem.title = title;
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    childController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@Sel", imageName]] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:[[UINavigationController alloc] initWithRootViewController:childController]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
