//
//  FlagViewController.swift
//  UIPickerViewDemo
//
//  Created by dfang on 2018-1-5.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class FlagViewController: ViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let flags = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "flags", ofType: "plist")!)!
    let pickerView = UIPickerView.init()
    
    override func viewDidLoad() {
        pickerView.frame = self.view.frame
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.view.addSubview(pickerView)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return flags.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var flagView = view as? FlagView
        if (nil == flagView) {
            flagView = FlagView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        }
        
        let dic = flags[row] as! NSDictionary
        flagView?.nameLabel.text = dic.value(forKey: "name") as? String
        flagView?.iconImageView.image = UIImage.init(named: dic.value(forKey: "icon") as! String)
        
        return flagView!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
}
