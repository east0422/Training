//
//  MicroBlogFooterView.h
//  CustomCell
//
//  Created by dfang on 2017-12-13.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MicroBlogFooterView;

@protocol MicroBlogFooterViewDelegate <NSObject>

@optional
- (void)footerViewDidClickedLoadMoreBtn:(MicroBlogFooterView *)microBlogFooterView;

@end

@interface MicroBlogFooterView : UIView

@property (nonatomic, strong) UIButton *loadMoreBtn;
@property (nonatomic, strong) UIView *loadingView;
@property (nonatomic, assign, readonly) CGFloat footerHeight;

@property (nonatomic, weak) id<MicroBlogFooterViewDelegate> delegate;

- (instancetype)initWithFooterHeight:(CGFloat)footerHeight;

@end
