//
//  CustomView.m
//  UIBasicExam
//
//  Created by dfang on 2017-12-21.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "CustomView.h"

@interface CustomView () {
    
}

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *smallest;
@property (nonatomic, strong) UIButton *small;
@property (nonatomic, strong) UIButton *big;
@property (nonatomic, strong) UIButton *biggest;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentSubViews];
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithFrame:self.superview.frame];
    if (self) {
        [self setContentSubViews];
    }
    return self;
}

- (void) setContentSubViews {
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, 60)];
    _title.textAlignment =NSTextAlignmentCenter;
    _title.text = @"测试文字";
    _title.font = [UIFont systemFontOfSize:8];
    _title.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_title];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, self.frame.size.width, 200)];
    subView.backgroundColor = [UIColor cyanColor];
    
    _smallest = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 70, 60)];
    _smallest.tag = 8;
    [self setBtnImage:_smallest withName:@"smallest"];
    [_smallest addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:_smallest];
    
    _small = [[UIButton alloc] initWithFrame:CGRectMake(80, 20, 70, 60)];
    _small.tag = 16;
    [self setBtnImage:_small withName:@"small"];
    [_small addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:_small];
    
    _big = [[UIButton alloc] initWithFrame:CGRectMake(160, 20, 70, 60)];
    _big.tag = 24;
    [self setBtnImage:_big withName:@"big"];
    [_big addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:_big];
    
    _biggest = [[UIButton alloc] initWithFrame:CGRectMake(240, 20, 70, 60)];
    _biggest.tag = 38;
    [self setBtnImage:_biggest withName:@"biggest"];
    [_biggest addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:_biggest];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, 60)];
    [_slider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    [_slider setMaximumTrackImage:[UIImage imageNamed:@"slider_normal"] forState:UIControlStateNormal];
    [_slider setMinimumTrackImage:[UIImage imageNamed:@"slider_highlight"] forState:UIControlStateNormal];
    _slider.value = 15;
    _slider.minimumValue = 8;
    _slider.maximumValue = 38;
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [subView addSubview:_slider];
    
    [self addSubview:subView];
}

- (void)setBtnImage:(UIButton *)btn withName:(NSString *)name{
    [btn setBackgroundImage: [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@_highlight", name]] forState:UIControlStateHighlighted];
    [btn setBackgroundImage: [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@_normal", name]] forState:UIControlStateNormal];
}

- (void)sliderValueChanged: (UISlider *)slider {
    _title.font = [UIFont systemFontOfSize:slider.value];
    [_smallest setHighlighted: false];
    [_small setHighlighted: false];
    [_big setHighlighted: false];
    [_biggest setHighlighted: false];
    if (slider.value > 6 && slider.value < 10) {
        [_smallest setHighlighted:true];
    } else if (slider.value > 14 && slider.value < 18) {
        [_small setHighlighted:true];
    } else if (slider.value > 22 && slider.value < 26) {
        [_big setHighlighted:true];
    } else if (slider.value > 34) {
        [_biggest setHighlighted:true];
    }
}

- (void)btnClicked: (UIButton *)btn {
    _title.font = [UIFont systemFontOfSize:btn.tag];
    _slider.value = btn.tag;
    
    [_smallest setHighlighted: false];
    [_small setHighlighted: false];
    [_big setHighlighted: false];
    [_biggest setHighlighted: false];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [btn setHighlighted:true];
    });
}

@end
