//
//  CustomView2.m
//  UIBasicExam
//
//  Created by dfang on 2017-12-22.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "CustomView2.h"

CGFloat minValue = 8;
CGFloat maxValue = 38;
CGFloat gap = 2;

@interface CustomView2 () {
}

@property (nonatomic, strong) UIButton *smallest;
@property (nonatomic, strong) UIButton *small;
@property (nonatomic, strong) UIButton *big;
@property (nonatomic, strong) UIButton *biggest;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation CustomView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setContentViews];
    }
    return self;
}

- (void) setContentViews {
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
    subView.backgroundColor = [UIColor cyanColor];
    
    CGFloat btnWidth = 70;
    CGFloat btnHeight = 60;
    CGFloat btnTop = 20;
    CGFloat margin = 10;
     _smallest = [[UIButton alloc] initWithFrame:CGRectMake(0, btnTop, btnWidth, btnHeight)];
    _smallest.tag = minValue;
    [self setBtnImage:_smallest withName:@"smallest"];
    [_smallest addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:_smallest];
    
    _small = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth + margin, btnTop, btnWidth, btnHeight)];
    _small.tag = minValue + (maxValue - minValue)/3;
    [self setBtnImage:_small withName:@"small"];
    [_small addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:_small];
    
    _big = [[UIButton alloc] initWithFrame:CGRectMake((btnWidth + margin) * 2, btnTop, btnWidth, btnHeight)];
    _big.tag = minValue + (maxValue - minValue)/3 * 2;
    [self setBtnImage:_big withName:@"big"];
    [_big addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:_big];
    
    _biggest = [[UIButton alloc] initWithFrame:CGRectMake((btnWidth + margin) * 3, btnTop, btnWidth, btnHeight)];
    _biggest.tag = maxValue;
    [self setBtnImage:_biggest withName:@"biggest"];
    [_biggest addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:_biggest];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 100, self.frame.size.width, 60)];
    [_slider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    [_slider setMaximumTrackImage:[UIImage imageNamed:@"slider_normal"] forState:UIControlStateNormal];
    [_slider setMinimumTrackImage:[UIImage imageNamed:@"slider_highlight"] forState:UIControlStateNormal];
    _slider.value = minValue;
    _slider.minimumValue = minValue;
    _slider.maximumValue = maxValue;
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [subView addSubview:_slider];
    
    [self addSubview:subView];
}

- (void)setBtnImage:(UIButton *)btn withName:(NSString *)name{
    [btn setBackgroundImage: [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@_highlight", name]] forState:UIControlStateHighlighted];
    [btn setBackgroundImage: [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@_normal", name]] forState:UIControlStateNormal];
}

- (void)resetBtnsToNormal {
    [_smallest setHighlighted: false];
    [_small setHighlighted: false];
    [_big setHighlighted: false];
    [_biggest setHighlighted: false];
}

- (void)sliderValueChanged: (UISlider *)slider {
    [self resetBtnsToNormal];
    
    if (slider.value > (_smallest.tag - gap) && slider.value < (_smallest.tag + gap)) {
        [_smallest setHighlighted:true];
    } else if (slider.value > (_small.tag - gap) && slider.value < (_small.tag + gap)) {
        [_small setHighlighted:true];
    } else if (slider.value > (_big.tag - gap) && slider.value < (_big.tag + gap)) {
        [_big setHighlighted:true];
    } else if (slider.value > (_biggest.tag - gap * 2)) {
        [_biggest setHighlighted:true];
    }
    
    [self callFontSizeChanged:slider.value];
}

- (void)btnClicked: (UIButton *)btn {
    [self resetBtnsToNormal];
    
    _slider.value = btn.tag;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [btn setHighlighted:true];
        [self callFontSizeChanged:btn.tag];
    });
}

- (void)callFontSizeChanged: (CGFloat)fontSize {
    if ([self.delegate respondsToSelector:@selector(fontSizeChanged:)]) {
        [self.delegate fontSizeChanged:fontSize];
    }
}

@end
