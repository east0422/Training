//
//  AddContactViewController.h
//  AddressBookDemo
//
//  Created by dfang on 2018-1-17.
//  Copyright © 2018年 east. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@protocol AddContactViewControllerDelegate <NSObject>

- (void)addContactViewControllerDidSaveContact: (Contact *)contact;

@end

@interface AddContactViewController : UIViewController

@property (nonatomic, assign) id<AddContactViewControllerDelegate> delegate;

@end
