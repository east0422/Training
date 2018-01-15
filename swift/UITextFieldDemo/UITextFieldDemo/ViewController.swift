//
//  ViewController.swift
//  UITextFieldDemo
//
//  Created by dfang on 2018-1-12.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KeyboardToolbarDelegate {
    @IBOutlet weak var fieldsContainerView: UIView!
    
    lazy var keyboardToolbar: KeyboardToolbar = {
        let keyboardToolbar = KeyboardToolbar.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        return keyboardToolbar
    }()
    
    var fields:Array<UITextField> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardToolbar.keyboardDelegate = self
        
        for subview in fieldsContainerView.subviews {
            if (subview.isKind(of: UITextField.self)) {
                let subTextField = subview as! UITextField
                subTextField.inputAccessoryView = keyboardToolbar
                fields.append(subTextField)
            }
        }
        
        // add notification for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notify:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidden(notify:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc func keyboardWillShow(notify: NSNotification) {
        guard let curTf = firstResponderTextField() else {
            return
        }
        guard let index = fields.index(of: curTf) else { return }
        keyboardToolbar.previousBtn.isEnabled = (index > 0)
        keyboardToolbar.nextBtn.isEnabled = (index < fields.count - 1)
        
        let userInfo = notify.userInfo!
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let deltaY = (fieldsContainerView.frame.origin.y + curTf.frame.maxY) - keyboardFrame.origin.y
        
        if (deltaY > 0) { // keyboard cover the first responder uitextfield
            UIView.animate(withDuration: duration, animations: {
                self.view.transform = CGAffineTransform.init(translationX: 0, y: -deltaY)
            })
        }
    }
    
    @objc func keyboardWillHidden(notify: NSNotification) {
        let duration = (notify.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        UIView.animate(withDuration: duration) {
            self.view.transform = CGAffineTransform.identity
        }
        
        // 还原工具条的item为可用
        keyboardToolbar.previousBtn.isEnabled = true
        keyboardToolbar.nextBtn.isEnabled = true
    }
    
    // KeyboardToolbarDelegate
    func btnDidClicked(btn: UIBarButtonItem) {
        guard let firstTf = firstResponderTextField() else { return }
        
        guard var index = fields.index(of: firstTf) else { return }
        
        switch btn.title! {
        case "上一个":
            if (index > 0) {
                index = index - 1
                firstTf.resignFirstResponder()
                fields[index].becomeFirstResponder()
            }
            break
        case "下一个":
            if (index < fields.count - 1) {
                index = index + 1
                firstTf.resignFirstResponder()
                fields[index].becomeFirstResponder()
            }
            break
        case "Done":
            fieldsContainerView.endEditing(true)
            break
        default:
            break
        }
    }
    
    func firstResponderTextField() -> UITextField? {
        for subTextField:UITextField in fields {
            if (subTextField.isFirstResponder) {
                return subTextField
            }
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fieldsContainerView.endEditing(true)
    }
}

