//
//  Exam4ViewController.swift
//  UIBasicExam
//
//  Created by dfang on 2017-12-28.
//  Copyright © 2017年 dfang. All rights reserved.
//

import Foundation
import UIKit

class Exam4ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    let reuseId = "exam4cellId"
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: self.view.frame, style: UITableViewStyle.plain)
        return tableView
    }()
    
    let dataArray = Exam4DataModel.dataModelList()
    
    lazy var stateArray: [NSNumber] = {
        let stateArray = NSMutableArray.init(capacity: dataArray.count)
        for i in 0...(dataArray.count-1) {
            stateArray.add(NSNumber.init(value: false))
        }
        return stateArray as! [NSNumber]
    }()
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 44 : 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateArray[section].boolValue ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseId)
        if (nil == cell) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseId)
        }
        
        if (indexPath.row == 0) {
            let dataModel:Exam4DataModel = dataArray[indexPath.section] as! Exam4DataModel
            cell!.imageView?.image = UIImage.init(named: dataModel.imageName)
            cell!.textLabel?.text = dataModel.titleName
        } else {
            cell!.imageView?.image = UIImage.init(named: "泡妞宝典")
            cell!.textLabel?.text = "测试"
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            stateArray[indexPath.section] = NSNumber.init(value: !stateArray[indexPath.section].boolValue)
            tableView.reloadSections(IndexSet.init(integer: indexPath.section), with: UITableViewRowAnimation.automatic)
        }
    }
}
