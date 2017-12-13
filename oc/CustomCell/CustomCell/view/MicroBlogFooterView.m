//
//  MicroBlogFooterView.m
//  CustomCell
//
//  Created by dfang on 2017-12-13.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

#import "MicroBlogFooterView.h"

#include "Constants.h"

@implementation MicroBlogFooterView

- (instancetype)initWithFooterHeight:(CGFloat)footerHeight {
    self = [super initWithFrame:CGRectMake(0, 0, SCREENWIDTH, footerHeight)];
    _footerHeight = footerHeight;
    if (self) {
        [self addSubview:self.loadMoreBtn];
        [self addSubview:self.loadingView];
    }
    
    return self;
}

- (UIButton *)loadMoreBtn {
    if (!_loadMoreBtn) {
        _loadMoreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, _footerHeight)];
        _loadMoreBtn.backgroundColor = [UIColor orangeColor];
        _loadMoreBtn.enabled = YES;
        [_loadMoreBtn setTitle:@"加载更多..." forState:UIControlStateNormal];
        _loadMoreBtn.layer.cornerRadius = 5;
        _loadingView.layer.masksToBounds = YES;
        [_loadMoreBtn addTarget:self action:@selector(loadMoreClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loadMoreBtn;
}

- (UIView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[UIView alloc] initWithFrame:CGRectMake((SCREENWIDTH - 200) / 2, 11, 200, _footerHeight - 11)];
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(20, 2, 20, 20)];
        [indicatorView startAnimating];
        [indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [_loadingView addSubview:indicatorView];
        
        UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 150, _footerHeight - 11)];
        loadingLabel.text = @"拼命加载中...";
        loadingLabel.textColor = [UIColor blackColor];
        [_loadingView addSubview:loadingLabel];
        
        _loadingView.hidden = YES;
    }
    return _loadingView;
}

- (void)loadMoreClick {
    self.loadMoreBtn.hidden = YES;
    self.loadingView.hidden = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.loadMoreBtn.hidden = NO;
        self.loadingView.hidden = YES;
        
        if ([self.delegate respondsToSelector:@selector(footerViewDidClickedLoadMoreBtn:)]) {
            [self.delegate footerViewDidClickedLoadMoreBtn:self];
        }
    });
}

@end
