//
//  ProvinceViewController.swift
//  UIPickerViewDemo
//
//  Created by dfang on 2018-1-5.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ProvinceViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let pickerView = UIPickerView.init()
    let provinceList = Province.provinceList()
    var provinceSelected = 0
    
    override func viewDidLoad() {
        pickerView.frame = self.view.frame
        pickerView.dataSource = self
        pickerView.delegate = self
        self.view.addSubview(pickerView)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return provinceList.count
        case 1:
            let province = provinceList[provinceSelected] as! Province
            return province.cities.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            let province = provinceList[row] as! Province
            return province.name
        } else {
            let province = provinceList[provinceSelected] as! Province
            return province.cities.object(at: row) as? String
        }
    }
    
    /*
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        if (component == 0) {
            let province = provinceList[row] as! Province
            let attributeStr = NSAttributedString.init(string: province.name, attributes: [NSAttributedStringKey.foregroundColor:UIColor.red])
            return attributeStr
        } else {
            let province = provinceList[provinceSelected] as! Province
            let str = province.cities.object(at: row) as! String
            return NSAttributedString.init(string: str, attributes: [NSAttributedStringKey.foregroundColor:UIColor.blue])
        }
    }
    */

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (component == 0) {
            provinceSelected = row
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
        }
    }
}
