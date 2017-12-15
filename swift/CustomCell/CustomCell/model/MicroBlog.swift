//
//  MicroBlog.swift
//  CustomCell
//
//  Created by dfang on 2017-12-14.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

import Foundation

class MicroBlog: NSObject {
    var text: String?
    var icon: String?
    var picture: String?
    var name: String?
    var vip: Bool
    
    override init() {
        text = nil
        icon = nil
        picture = nil
        name = nil
        vip = false
    }
    
    init(dict: NSDictionary) {
        text = dict.value(forKey: "text") as? String
        icon = dict.value(forKey: "icon") as? String
        picture = dict.value(forKey: "picture") as? String
        name = dict.value(forKey: "name") as? String
        vip = dict.value(forKey: "vip") as! Bool
    }
    
    class func microBlogList() -> NSArray {
        let path = Bundle.main.path(forResource: "microblog", ofType: "plist")
        let microBlogs = NSArray.init(contentsOfFile: path!)
        let microBlogList = NSMutableArray.init(capacity: (microBlogs?.count)!)
        
        for microBlog in microBlogs! {
            microBlogList.add(MicroBlog.init(dict: microBlog as! NSDictionary))
        }
        
        return microBlogList
    }
}
