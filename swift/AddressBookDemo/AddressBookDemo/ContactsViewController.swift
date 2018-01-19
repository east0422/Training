//
//  ContactsViewController.swift
//  AddressBookDemo
//
//  Created by dfang on 2018-1-18.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ContactsViewController: UITableViewController, AddContactViewControllerDelegate, EditContactViewControllerDelegate {
    
    @IBOutlet var tableview: UITableView!

    lazy var contactPath:String = {
        let docPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!
        return docPath + "/contacts.archiver"
    }()
    
    lazy var contacts: NSMutableArray = {
        var contacts = NSKeyedUnarchiver.unarchiveObject(withFile: contactPath) as? NSMutableArray
        if contacts == nil {
            contacts = NSMutableArray.init()
        }
        return contacts!
    }()
    
    var name:String?
    
    override func viewDidLoad() {
        self.title = name! + "的个人通讯录"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCellReuseId")
        let contact:Contact = contacts.object(at: indexPath.row) as! Contact
        cell?.textLabel?.text = contact.name
        cell?.detailTextLabel?.text = contact.phone
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            contacts.removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            
            NSKeyedArchiver.archiveRootObject(contacts, toFile: contactPath)
        }
    }
    
    @IBAction func logoutItemClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteItemClicked(_ sender: UIBarButtonItem) {
        tableview.setEditing(!tableview.isEditing, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        if (vc.isKind(of: AddContactViewController.self)) {
            let addContactVC = vc as! AddContactViewController
            addContactVC.delegate = self
        } else if (vc.isKind(of: EditContactViewController.self)) {
            let editContactVC = vc as! EditContactViewController
            editContactVC.delegate = self
            
            let indexPath = tableview.indexPathForSelectedRow
            editContactVC.contact = contacts.object(at: (indexPath?.row)!) as! Contact
        }
    }
    
    // AddContactViewControllerDelegate
    func addContactViewControllerDidSaveContact(contact: Contact) {
        contacts.add(contact)
        let lastIndexPath = IndexPath.init(row: contacts.count - 1, section: 0)
        tableview.insertRows(at: [lastIndexPath], with: UITableViewRowAnimation.fade)
        navigationController?.popViewController(animated: true)
        
        NSKeyedArchiver.archiveRootObject(contacts, toFile: contactPath)
    }
    
    // EditContactViewControllerDelegate
    func editContactViewControllerDidSaveContact(contact: Contact) {
        let index = contacts.index(of: contact)
        let refreshIndexPath = IndexPath.init(row: index, section: 0)
        tableview.reloadRows(at: [refreshIndexPath], with: UITableViewRowAnimation.fade)
        navigationController?.popViewController(animated: true)
        
        NSKeyedArchiver.archiveRootObject(contacts, toFile: contactPath)
    }
    
}
