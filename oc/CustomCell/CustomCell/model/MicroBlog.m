//
//  MicroBlog.m
//  CustomCell
//
//  Created by dfang on 2017-12-13.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

#import "MicroBlog.h"

#include "Constants.h"

@implementation MicroBlog

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)microBlogWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

+ (NSArray *)microBlogList {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"microblog" ofType:@"plist"];
    NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithCapacity:dicArr.count];
    for (NSDictionary *dic in dicArr) {
        MicroBlog *microBlog = [MicroBlog microBlogWithDic:dic];
        [microBlog setSubViewsFrame];
        [tmpArray addObject:microBlog];
    }
    return tmpArray;
}

// 计算自适应行高
- (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize andFontsize:(CGFloat)fontsize {
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size;
}

- (void)setSubViewsFrame
{
    CGFloat margin = 10;
    
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGSize nameSize = [self sizeWithText:_name maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFontsize:MicroBlogTitleFont];
    CGFloat nameX = CGRectGetMaxX(_iconFrame) + margin;
    CGFloat nameY = iconY + (iconH - nameSize.height)/2;
    _nameFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    CGFloat vipW = 14;
    CGFloat vipH = 14;
    CGFloat vipY = nameY;
    CGFloat vipX = CGRectGetMaxX(_nameFrame) + margin;
    _vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    
    CGSize textSize = [self sizeWithText:_text maxSize:CGSizeMake(SCREENWIDTH - margin, MAXFLOAT) andFontsize:MicroBlogDescFont];
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(_iconFrame) + margin;
    _textFrame = CGRectMake(textX, textY, textSize.width, textSize.height);
    
    if (self.picture) {
        CGFloat pictureW = 100;
        CGFloat pictureH = 100;
        CGFloat pictureX = iconX;
        CGFloat pictureY = CGRectGetMaxY(_textFrame) + margin;
        _pictureFrame = (CGRect){{pictureX,pictureY},{pictureW,pictureH}};
        
        _rowHeight = CGRectGetMaxY(_pictureFrame) + margin;
    }else{
        _rowHeight = CGRectGetMaxY(_textFrame) + margin;
    }
}

@end
