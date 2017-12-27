//
//  Exam4DataModel.swift
//  UIBasicExam
//
//  Created by dfang on 2017-12-28.
//  Copyright © 2017年 dfang. All rights reserved.
//

import Foundation

class Exam4DataModel: NSObject {
    var titleName:String
    var imageName:String
    
    init(dic:NSDictionary) {
        titleName = dic.value(forKey: "titileName") as! String
        imageName = dic.value(forKey: "imageName") as! String
    }
    
    class func dataModelList() -> NSMutableArray {
        let dataArray:NSArray = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "Data", ofType: "plist")!)!
        let dataList = NSMutableArray.init(capacity: dataArray.count)
        for dic in dataArray {
            dataList.add(Exam4DataModel.init(dic: dic as! NSDictionary))
        }
        return dataList
    }
}
