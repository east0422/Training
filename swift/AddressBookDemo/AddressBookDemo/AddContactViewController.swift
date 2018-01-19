//
//  AddContactViewController.swift
//  AddressBookDemo
//
//  Created by dfang on 2018-1-18.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

@objc protocol AddContactViewControllerDelegate: NSObjectProtocol {
    @objc func addContactViewControllerDidSaveContact(contact:Contact)
}

class AddContactViewController: UIViewController, UITextFieldDelegate {
    
    var delegate:AddContactViewControllerDelegate?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func textChanged() {
        saveBtn.isEnabled = (nameField.text != nil && nameField.text!.count > 0 && phoneField.text != nil && phoneField.text!.count > 0)
    }
    
    @IBAction func saveBtnClicked() {
        if (delegate!.responds(to: #selector(AddContactViewControllerDelegate.addContactViewControllerDidSaveContact(contact:)))) {
            let contact = Contact.init(name: nameField.text, andPhone: phoneField.text)
            delegate?.addContactViewControllerDidSaveContact(contact: contact)
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
