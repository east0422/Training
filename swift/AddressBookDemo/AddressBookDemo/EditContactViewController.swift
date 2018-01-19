//
//  EditContactViewController.swift
//  AddressBookDemo
//
//  Created by dfang on 2018-1-18.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

@objc protocol EditContactViewControllerDelegate: NSObjectProtocol {
    @objc func editContactViewControllerDidSaveContact(contact:Contact)
}

class EditContactViewController: UIViewController, UITextFieldDelegate {
    
    var delegate:EditContactViewControllerDelegate?
    var contact:Contact!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var editItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        nameField.text = contact?.name
        phoneField.text = contact?.phone
        textChanged()
    }
    
    @IBAction func textChanged() {
        saveBtn.isEnabled = (nameField.text != nil && nameField.text!.count > 0 && phoneField.text != nil && phoneField.text!.count > 0)
    }
    
    @IBAction func editItemClicked(_ sender: UIBarButtonItem) {
        if (sender.title == "编辑") {
            sender.title = "取消"
            nameField.isEnabled = false
            phoneField.isEnabled = false
            saveBtn.isEnabled = false
        } else {
            sender.title = "编辑"
            nameField.isEnabled = true
            phoneField.isEnabled = true
            saveBtn.isEnabled = true
        }
    }
    
    @IBAction func saveBtnClicked() {
        if delegate!.responds(to: #selector(EditContactViewControllerDelegate.editContactViewControllerDidSaveContact(contact:))) {
            contact.name = nameField.text
            contact.phone = phoneField.text
            delegate?.editContactViewControllerDidSaveContact(contact: contact)
        }
    }
    
    // UITextfieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
