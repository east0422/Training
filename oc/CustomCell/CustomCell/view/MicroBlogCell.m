//
//  MicroBlogCell.m
//  CustomCell
//
//  Created by dfang on 2017-12-13.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

#import "MicroBlogCell.h"

#include "Constants.h"

@interface MicroBlogCell () {

}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *pictureImageView;
@property (nonatomic, strong) UIImageView *vipImageView;

@end

@implementation MicroBlogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)microBlogCellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)cellStyle{
    MicroBlogCell *cell = [tableView dequeueReusableCellWithIdentifier: microBlogCellReuseId];
    if (!cell) {
        cell = [[MicroBlogCell alloc] initWithStyle:cellStyle reuseIdentifier:microBlogCellReuseId];
    }
    return cell;
}

// override
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:microBlogCellReuseId];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:MicroBlogTitleFont];
        [self.contentView addSubview:_titleLabel];
        
        _descLabel = [[UILabel alloc] init];
        _descLabel.numberOfLines = 0; // 自动换行
        _descLabel.font = [UIFont systemFontOfSize:MicroBlogDescFont];
        [self.contentView addSubview:_descLabel];
        
        _iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImageView];
        
        _pictureImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_pictureImageView];
        
        _vipImageView = [[UIImageView alloc] init];
        _vipImageView.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:_vipImageView];
    }
    return self;
}

- (void)setMicroBlog:(MicroBlog *)microBlog {
    _microBlog = microBlog;
    
    // set subviews content
    _titleLabel.text = _microBlog.name;
    _descLabel.text = _microBlog.text;
    _iconImageView.image = [UIImage imageNamed:_microBlog.icon];
    if (_microBlog.picture) {
        _pictureImageView.image = [UIImage imageNamed:_microBlog.picture];
    }
    
    if (_microBlog.isVip) {
        _vipImageView.hidden = NO;
        _titleLabel.textColor = [UIColor redColor];
    } else {
        _vipImageView.hidden = YES;
        _titleLabel.textColor = [UIColor blackColor];
    }
    
    // set subviews frame
    _titleLabel.frame = _microBlog.nameFrame;
    _descLabel.frame = _microBlog.textFrame;
    _iconImageView.frame = _microBlog.iconFrame;
    _pictureImageView.frame = _microBlog.pictureFrame;
    _vipImageView.frame = _microBlog.vipFrame;
}

@end
