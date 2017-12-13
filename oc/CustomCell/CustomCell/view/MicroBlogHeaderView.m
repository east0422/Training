//
//  MicroBlogHeaderView.m
//  CustomCell
//
//  Created by dfang on 2017-12-13.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

#import "MicroBlogHeaderView.h"

#include "Constants.h"

@interface MicroBlogHeaderView () <UIScrollViewDelegate> {

}

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageController;
@property (nonatomic, assign) CGFloat headerHeight;

@end

@implementation MicroBlogHeaderView

- (instancetype)initWithHeaderHeight:(CGFloat)headerHeight {
    self = [super initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headerHeight)];
    _headerHeight = headerHeight;
    if (self) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageController];
    }
    
    return self;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, _headerHeight)];
        
        for (int i = 0; i < 5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"ad_%02d",i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * SCREENWIDTH, 0, SCREENWIDTH, _headerHeight)];
            imageView.image = [UIImage imageNamed:imageName];
            [_scrollView addSubview:imageView];
        }
        _scrollView.contentSize = CGSizeMake(5 * SCREENWIDTH, _headerHeight);
        _scrollView.delegate = self;
    }
    
    return _scrollView;
}

- (UIPageControl *)pageController {
    if (!_pageController) {
        _pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _headerHeight - 20, SCREENWIDTH, 20)];
        _pageController.numberOfPages = 5;
        _pageController.currentPage = 0;
        _pageController.pageIndicatorTintColor = [UIColor whiteColor];
        _pageController.currentPageIndicatorTintColor = [UIColor yellowColor];
    }
    return _pageController;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger curPage = (scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width;
    _pageController.currentPage = curPage;
}

@end
