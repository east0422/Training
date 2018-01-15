//
//  KeyboardToolbar.swift
//  UITextFieldDemo
//
//  Created by dfang on 2018-1-12.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

@objc protocol KeyboardToolbarDelegate: NSObjectProtocol {
    @objc optional func btnDidClicked(btn: UIBarButtonItem)
}

class KeyboardToolbar: UIToolbar {
    
    var keyboardDelegate: KeyboardToolbarDelegate?
    let previousBtn = UIBarButtonItem.init(title: "上一个", style: UIBarButtonItemStyle.plain, target: self, action: #selector(btnClicked(btn:)))
    let nextBtn = UIBarButtonItem.init(title: "下一个", style: UIBarButtonItemStyle.plain, target: self, action: #selector(btnClicked(btn:)))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let flexibleBtn = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let doneBtn = UIBarButtonItem.init(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(btnClicked(btn:)))
        self.items = [previousBtn, nextBtn, flexibleBtn, doneBtn]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnClicked(btn: UIBarButtonItem) {
        if (keyboardDelegate?.responds(to: #selector(KeyboardToolbarDelegate.btnDidClicked(btn:))))! {
            keyboardDelegate?.btnDidClicked!(btn: btn)
        }
    }
}
