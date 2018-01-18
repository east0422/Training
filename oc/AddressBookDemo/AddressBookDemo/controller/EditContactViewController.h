//
//  EditContactViewController.h
//  AddressBookDemo
//
//  Created by dfang on 2018-1-17.
//  Copyright © 2018年 east. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@protocol EditContactViewControllerDelegate <NSObject>

- (void)editContactViewControllerDidSaveContact:(Contact *)contact;

@end

@interface EditContactViewController : UIViewController

@property (nonatomic, strong) Contact *contact;
@property (nonatomic, assign) id<EditContactViewControllerDelegate> delegate;

@end
