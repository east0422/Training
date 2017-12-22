//
//  CustomDataModel.h
//  UIBasicExam
//
//  Created by dfang on 2017-12-25.
//  Copyright © 2017年 com.east. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomDataModel : NSObject

@property (nonatomic, copy) NSString *titileName;
@property (nonatomic, copy) NSString *imageName;

- (instancetype)initWithDic: (NSDictionary *)dic;
+ (instancetype)customDataModelWithDic: (NSDictionary *)dic;

+ (NSMutableArray *)custDataList;


@end
