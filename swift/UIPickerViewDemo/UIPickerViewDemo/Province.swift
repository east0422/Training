//
//  Province.swift
//  UIPickerViewDemo
//
//  Created by dfang on 2018-1-5.
//  Copyright © 2018年 east. All rights reserved.
//

import Foundation

class Province: NSObject {
    var name: String!
    var cities: NSArray!
    
    init(dic: NSDictionary) {
        name = dic.value(forKey: "name") as! String
        cities = dic.value(forKey: "cities") as! NSArray
    }
    
    class func provinceList() -> NSMutableArray {
        let provinces = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "provinces", ofType: "plist")!)!
        let provinceList = NSMutableArray.init(capacity: provinces.count)
        for dic in provinces {
            let province = Province.init(dic: dic as! NSDictionary)
            provinceList.add(province)
        }
        
        return provinceList
    }
}
