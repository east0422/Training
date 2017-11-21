//
//  CarGroup.swift
//  UITableViewDemo
//
//  Created by dfang on 2017-11-21.
//  Copyright © 2017年 com.east. All rights reserved.
//

import UIKit

class CarGroup: NSObject {
    
    var title: String?
    var cars: Array<String>?
    var desc: String?
    
    init(dict: NSDictionary) {
        super.init()
        title = dict.value(forKey: "title") as? String
        cars = dict.value(forKey: "cars") as? Array<String>
        desc = dict.value(forKey: "desc") as? String
    }
    
    class func carGroupList() -> NSArray {
        let carGroupList = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "cars_simple", ofType: "plist")!)!
        let carGroupListM = NSMutableArray.init(capacity: carGroupList.count)
        
        for carGroup in carGroupList {
            carGroupListM.add(CarGroup.init(dict: carGroup as! NSDictionary))
        }
        
        return carGroupListM
    }

}
