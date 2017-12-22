//
//  Exam5ViewController.m
//  UIBasicExam
//
//  Created by dfang on 2017-12-25.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "Exam5ViewController.h"

@interface Exam5ViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *sunImageView;
@property (nonatomic, strong) UIImageView *contentImageView;

@end

@implementation Exam5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"520_userguid_bg"]];
    [_scrollView addSubview:bg];
    
    UIImageView *cloud = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"520_userguid_cloud"]];
    [_scrollView addSubview:cloud];
    
    UIImageView *bottom = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"520_userguid_fg"]];
    bottom.frame = CGRectMake(0, screenSize.height - bottom.frame.size.height, bottom.frame.size.width, bottom.frame.size.height);
    [_scrollView addSubview:bottom];
    
    UIImageView *words = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"520_userguid_words_5"]];
    words.frame = CGRectMake(0, 70, screenSize.width, 100);
    [_scrollView addSubview:words];
    
    UIImageView *cg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"520_userguid_cg"]];
    [_scrollView addSubview:cg];
    
    _sunImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"520_userguid_sun"]];
    _sunImageView.frame = CGRectMake(screenSize.width - 60, 10, 60, 60);
    [_scrollView addSubview:_sunImageView];
    
    _contentImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"520_userguid_person_weigou"]];
    _contentImageView.frame = CGRectMake((screenSize.width - 150)/2, screenSize.height - 200, 150, 150);
    NSArray *moveArray = @[[UIImage imageNamed:@"520_userguid_person_taitou_1"], [UIImage imageNamed:@"520_userguid_person_ditou_1"], [UIImage imageNamed:@"520_userguid_person_taitou_2"], [UIImage imageNamed:@"520_userguid_person_ditou_2"]];
    _contentImageView.animationImages = moveArray;
    _contentImageView.animationDuration = 0.5;
    [_scrollView addSubview:_contentImageView];
    
    _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(bg.frame), screenSize.height);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_contentImageView startAnimating];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100;
    // 开始动画
    [_sunImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_contentImageView stopAnimating];
    // 结束动画
    [_sunImageView.layer removeAnimationForKey:@"rotationAnimation"];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat moveX = scrollView.contentOffset.x;
    CGRect sumFrame = _sunImageView.frame;
    CGRect contentFrame = _contentImageView.frame;
    sumFrame.origin.x = moveX + (scrollView.frame.size.width - 60);
    contentFrame.origin.x = moveX + (scrollView.frame.size.width - 150)/2;
    
    _sunImageView.frame = sumFrame;
    _contentImageView.frame = contentFrame;
}

@end
