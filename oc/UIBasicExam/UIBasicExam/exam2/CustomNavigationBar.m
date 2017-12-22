//
//  CustomNavigationBar.m
//  UIBasicExam
//
//  Created by dfang on 2017-12-22.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import "CustomNavigationBar.h"

@interface CustomNavigationBar ()

@property (nonatomic, strong) NSMutableArray *btns;

@end

@implementation CustomNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _btns = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    UIButton *preBtn = nil;
    NSInteger index = 1;
    for (NSString *str in _dataArray) {
        CGSize btnSize = [self sizeOfText:str];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(preBtn.frame)  + 10, 0, btnSize.width, btnSize.height + 10)];
        btn.tag = index;
        [btn setSelected:(index == 1)];
        index++;
        
        NSMutableAttributedString *normalStr = [[NSMutableAttributedString alloc] initWithString:str];
        [normalStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleNone) range:NSMakeRange(0, str.length)];
        [normalStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, str.length)];
        [btn setAttributedTitle:normalStr forState:UIControlStateNormal];
        
        NSMutableAttributedString *btnStr = [[NSMutableAttributedString alloc] initWithString:str];
        [btnStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, str.length)];
        [btnStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str.length)];
        [btnStr addAttribute:NSUnderlineColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str.length)];
        [btn setAttributedTitle:btnStr forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        preBtn = btn;

        [_btns addObject:btn];
        [self addSubview:btn];
    }
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (CGRectGetMaxX(preBtn.frame) + 50 < screenWidth) { // 空余大于50，平分屏幕宽度
        int i = 0;
        CGFloat btnWidth = screenWidth / _btns.count;
        for (UIButton *button in _btns) {
            button.frame = CGRectMake(i*btnWidth, button.frame.origin.y, btnWidth, button.frame.size.height);
            i++;
        }
    } else { // 空余小于50，左右平分剩余空白
        CGFloat marginLeft = (self.frame.size.width -  CGRectGetMaxX(preBtn.frame)) / 2;
        self.frame = CGRectMake(self.frame.origin.x + marginLeft, self.frame.origin.y, (self.frame.size.width - marginLeft * 2), self.frame.size.height);
    }
}

- (void)btnClicked:(UIButton *)btn {
    for (UIButton *button in self.btns) {
        if (button == btn) {
            [button setSelected:true];
        } else {
            [button setSelected:false];
        }
    }
}

- (CGSize)sizeOfText:(NSString *)text {
    return [text boundingRectWithSize:CGSizeMake(300, 150) options:NSStringDrawingUsesLineFragmentOrigin attributes: @{NSFontAttributeName: [UIFont systemFontOfSize: 18]} context:nil].size;
}

@end
