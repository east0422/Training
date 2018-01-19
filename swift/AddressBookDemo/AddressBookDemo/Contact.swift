//
//  Contact.swift
//  AddressBookDemo
//
//  Created by dfang on 2018-1-18.
//  Copyright © 2018年 east. All rights reserved.
//

import Foundation

class Contact: NSObject, NSCoding {
    var name:String?
    var phone:String?
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(phone, forKey: "phone")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
    }
    
    init(name _name:String?, andPhone _phone:String?) {
        name = _name
        phone = _phone
    }
}
