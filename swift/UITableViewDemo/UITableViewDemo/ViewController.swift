//
//  ViewController.swift
//  UITableViewDemo
//
//  Created by dfang on 2017-11-20.
//  Copyright © 2017年 com.east. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    let tableView: UITableView = UITableView.init(frame: UIScreen.main.bounds, style: UITableViewStyle.grouped)
    let reuseIdentifier: String = "reuseid"
    lazy var carGroupList: NSArray? = CarGroup.carGroupList()
    lazy var carGroupTotalList:NSArray? = CarGroupTotal.carGroupList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if (nil != carGroupTotalList) {
//            return carGroupList!.count
            return carGroupTotalList!.count
        } else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let carGroup: CarGroup = carGroupList![section] as! CarGroup
//        return carGroup.cars!.count;
        let carGroupTotal: CarGroupTotal = carGroupTotalList![section] as! CarGroupTotal
        return carGroupTotal.cars!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if nil == cell {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        }
        cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell!.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
//        let carGroup: CarGroup = carGroupList![indexPath.section] as! CarGroup
//        cell!.textLabel?.text = carGroup.cars![indexPath.row]
        let carGroupTotal: CarGroupTotal = carGroupTotalList![indexPath.section] as! CarGroupTotal
        let car: Car = carGroupTotal.cars![indexPath.row] as! Car
        cell!.textLabel?.text = car.name
        cell!.imageView?.image = UIImage.init(named: car.icon!)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return (carGroupList![section] as! CarGroup).title
        return (carGroupTotalList![section] as! CarGroupTotal).title
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return (carGroupList![section] as! CarGroup).desc
        return ""
    }
    
}

