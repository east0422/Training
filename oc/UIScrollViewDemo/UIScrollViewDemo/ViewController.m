//
//  ViewController.m
//  UIScrollViewDemo
//
//  Created by dfang on 2017-11-1.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 设置滚动范围
//    self.scrollView.contentSize = CGSizeMake(1600, 1067);
    // 设置间距
//    self.scrollView.contentInset = UIEdgeInsetsMake(20, 20, 20, 20);
    // 设置窗口相对图片左上角偏移量,默认(0,0)
//    self.scrollView.contentOffset = CGPointMake(-100, -50);
    
    /* // just test EPersonDelegate
        EPerson *mr = [[EPerson alloc] init];
        mr.name = @"王总";
        mr.delegate = self;
        [mr doSomething];
     */
    
    int count = 5;
    CGSize size = self.view.frame.size;
    self.scrollView.contentSize = CGSizeMake(size.width * count, 0);
    for (int i = 0; i < count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * size.width, 0, size.width, size.height)];
        NSString *imageName = [NSString stringWithFormat:@"img_%02d",i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.pageControl.numberOfPages = count;
    
    [self addImageTimer];
}

- (void)addImageTimer {
    /* // scheduledTimerWithTimeInterval timer会被加入到当前线程的Run Loop中，且模式是默认的NSDefaultRunLoopMode
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        int nextPage = (self.pageControl.currentPage + 1) % (int)self.pageControl.numberOfPages;
        // amend scrollview contenOffset will call scrollViewDidScroll:
        //        self.pageControl.currentPage = nextPage;
        [UIView animateWithDuration:1 animations:^{
            self.scrollView.contentOffset = CGPointMake(nextPage * self.scrollView.frame.size.width, 0);
        } completion:^(BOOL finished) {
            
        }];
    }];
    */
    self.timer = [NSTimer timerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        int nextPage = (self.pageControl.currentPage + 1) % (int)self.pageControl.numberOfPages;
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

#pragma mark - scrollview scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width / 2 ) / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addImageTimer];
}

- (void)meeting:(EPerson *)person {
    NSLog(@"%@ 在开会!", person.name);
}

- (IBAction)moveClicked:(UIButton *)sender {
    CGPoint offset = self.scrollView.contentOffset;
    if (offset.x >= self.scrollView.frame.size.width * self.pageControl.numberOfPages) {
        offset.x = 0;
    } else {
        offset.x += 50;
    }
    
//    [self.scrollView setContentOffset:offset animated:YES];
    
    [UIView animateWithDuration:1.0f animations:^{
        self.scrollView.contentOffset = offset;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
