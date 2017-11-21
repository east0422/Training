//
//  Car.swift
//  UITableViewDemo
//
//  Created by dfang on 2017-11-21.
//  Copyright © 2017年 com.east. All rights reserved.
//

import Foundation

class Car: NSObject {
    var name: String?
    var icon: String?
    
    init(dict: NSDictionary) {
        name = dict.value(forKey: "name") as? String ?? ""
        icon = dict.value(forKey: "icon") as? String ?? ""
    }
}
