//
//  Contact.h
//  AddressBookDemo
//
//  Created by dfang on 2018-1-17.
//  Copyright © 2018年 east. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject<NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;

@end
