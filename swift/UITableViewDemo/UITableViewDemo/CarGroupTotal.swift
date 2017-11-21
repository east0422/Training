//
//  CarGroupTotal.swift
//  UITableViewDemo
//
//  Created by dfang on 2017-11-21.
//  Copyright © 2017年 com.east. All rights reserved.
//

import Foundation

class CarGroupTotal: NSObject {
    var title: String?
    var cars: NSMutableArray?
    
    init(dict: NSDictionary) {
        title = dict.value(forKey: "title") as? String ?? ""
        
        let carList = dict.value(forKey: "cars") as? NSArray ?? nil
        if (nil != carList) {
            cars = NSMutableArray.init(capacity: (carList?.count)!)
            for carDict in carList! {
                cars!.add(Car.init(dict: carDict as! NSDictionary))
            }
        }
    }
    
    class func carGroupList() -> NSArray {
        let carGroupList = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "cars_total", ofType: "plist")!)
        let carGroupTotalList = NSMutableArray.init(capacity: (carGroupList?.count)!)
        
        for carGroup in carGroupList! {
            carGroupTotalList.add(CarGroupTotal.init(dict: carGroup as! NSDictionary))
        }
        
        return carGroupTotalList
    }
}
