//
//  ContactsViewController.m
//  AddressBookDemo
//
//  Created by dfang on 2018-1-17.
//  Copyright © 2018年 east. All rights reserved.
//

#import "ContactsViewController.h"
#import "Contact.h"
#import "AddContactViewController.h"
#import "EditContactViewController.h"

@interface ContactsViewController () <AddContactViewControllerDelegate, EditContactViewControllerDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy) NSString *contactPath;
@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = [NSString stringWithFormat:@"%@的个人通讯录", self.name];
}

- (NSString *)contactPath {
    if (_contactPath == nil) {
        _contactPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.archiver"];
        NSLog(@"%@", _contactPath);
        // /var/mobile/Containers/Data/Application/C8899330-0926-4148-9CC0-9C8E181DF16A/Documents/contacts.archiver
        // /var/mobile/Containers/Data/Application/8BC1CA08-F459-4BF4-8545-134DE1DC0CC2/Documents/contacts.archiver
        // /var/mobile/Containers/Data/Application/D0F09697-B37F-4459-B71A-60B83BA969CC/Documents
    }
    return _contactPath;
}

- (NSMutableArray *)contacts {
    if (_contacts == nil) {
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:self.contactPath];
        if (_contacts == nil) {
            _contacts = [NSMutableArray array];
        }
    }
    return _contacts;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // contactCellReuseId storyboard中设置
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCellReuseId"];
    Contact *contact = self.contacts[indexPath.row];
    cell.textLabel.text = contact.name;
    cell.detailTextLabel.text = contact.phone;
    
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contacts removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];
    }
}

- (IBAction)logout:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteItemClicked:(id)sender {
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id destVC = segue.destinationViewController;
    if ([destVC isKindOfClass:[AddContactViewController class]]) {
        AddContactViewController *addContactVC = destVC;
        addContactVC.delegate = self;
    } else if ([destVC isKindOfClass:[EditContactViewController class]]) {
        EditContactViewController *editContactVC = destVC;
        editContactVC.delegate = self;
        
        NSIndexPath *selectedIndex = self.tableView.indexPathForSelectedRow;
        Contact *contact = self.contacts[selectedIndex.row];
        editContactVC.contact = contact;
    }
}

- (void)addContactViewControllerDidSaveContact:(Contact *)contact {
    [self.contacts addObject:contact];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.contacts.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.navigationController popViewControllerAnimated:YES];
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];
}

- (void)editContactViewControllerDidSaveContact:(Contact *)contact {
    NSIndexPath *refreshPath = [NSIndexPath indexPathForRow: [self.contacts indexOfObject:contact] inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[refreshPath] withRowAnimation:UITableViewRowAnimationFade];
    
    [self.navigationController popViewControllerAnimated:YES];
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:self.contactPath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
