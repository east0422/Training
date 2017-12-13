//
//  MicroBlogCell.h
//  CustomCell
//
//  Created by dfang on 2017-12-13.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

#import "MicroBlog.h"

@interface MicroBlogCell : UITableViewCell

@property (nonatomic, strong) MicroBlog *microBlog;

+ (instancetype)microBlogCellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)cellStyle;

@end
