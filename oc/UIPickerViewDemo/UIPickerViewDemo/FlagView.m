//
//  FlagView.m
//  UIPickerViewDemo
//
//  Created by dfang on 2018-1-9.
//  Copyright © 2018年 east. All rights reserved.
//

#import "FlagView.h"

@implementation FlagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.iconImageView];
    }
    return self;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, self.frame.size.height)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _nameLabel;
}

- (UIImageView *)iconImageView {
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 0, 100, self.frame.size.height)];
    }
    return _iconImageView;
}

@end
