//
//  Contact.m
//  AddressBookDemo
//
//  Created by dfang on 2018-1-17.
//  Copyright © 2018年 east. All rights reserved.
//

#import "Contact.h"

#define nameKey @"name"
#define phoneKey @"phone"

@implementation Contact

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        // 切记要赋值
        self.name = [coder decodeObjectForKey:nameKey];
        self.phone = [coder decodeObjectForKey:phoneKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:nameKey];
    [coder encodeObject:self.phone forKey:phoneKey];
}

@end
