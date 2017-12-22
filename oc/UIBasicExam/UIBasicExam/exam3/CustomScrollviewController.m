//
//  CustomScrollviewController.m
//  UIBasicExam
//
//  Created by dfang on 2017-12-24.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "CustomScrollviewController.h"

@interface CustomScrollviewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CustomScrollviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.view.backgroundColor = [UIColor whiteColor];
    
    int sum = 5;
    for (int i = 0; i < sum; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * screenSize.width, 0, screenSize.width, 150)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_%02d",(i+1)]];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(screenSize.width * sum, 150);
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate = self;
    
    self.pageController.numberOfPages = sum;
    [self.view addSubview:self.pageController];
    
    [self addImageTimer];
}

- (UIScrollView *)scrollView {
    if (nil == _scrollView) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, screenSize.width, 150)];
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
    }
    
    return _scrollView;
}

- (UIPageControl *)pageController {
    if (nil == _pageController) {
         CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 170, screenSize.width, 24)];
        _pageController.currentPage = 0;
        _pageController.currentPageIndicatorTintColor = [UIColor redColor];
        _pageController.pageIndicatorTintColor = [UIColor blueColor];
    }
    
    return _pageController;
}

#pragma mark --- scrollviewdelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageController.currentPage = (scrollView.contentOffset.x + scrollView.frame.size.width /2 ) / scrollView.frame.size.width;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addImageTimer];
}

- (void)addImageTimer {
    self.timer = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        int nextPage = (self.pageController.currentPage + 1) % (int)self.pageController.numberOfPages;
        // amend scrollview contenOffset will call scrollViewDidScroll:
        //        self.pageControl.currentPage = nextPage;
        [UIView animateWithDuration:1 animations:^{
            self.scrollView.contentOffset = CGPointMake(nextPage * self.scrollView.frame.size.width, 0);
        } completion:^(BOOL finished) {
            
        }];
    }];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    // NSDefaultRunLoopMode，如果当前线程就是主线程，也就是UI线程时，某些UI事件，比如UIScrollView的拖动操作，会将Run Loop切换成NSEventTrackingRunLoopMode模式，在这个过程中，默认的NSDefaultRunLoopMode模式中注册的事件是不会被执行的
    [runloop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

@end
