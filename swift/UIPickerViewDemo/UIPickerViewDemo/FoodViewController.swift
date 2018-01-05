//
//  FoodViewController.swift
//  UIPickerViewDemo
//
//  Created by dfang on 2018-1-5.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class FoodViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let pickerView:UIPickerView = UIPickerView.init()
    
    let headerView = UIView.init()
    let foods = NSArray.init(contentsOfFile: Bundle.main.path(forResource: "foods", ofType: "plist")!)!
    
    let fruitLabel = UILabel.init()
    let foodLabel = UILabel.init()
    let drinkLabel = UILabel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let screenWidth = UIScreen.main.bounds.width
        headerView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 64)
        let titleLabel = UILabel.init(frame: headerView.frame)
        titleLabel.text = "点菜系统"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = NSTextAlignment.center
        headerView.addSubview(titleLabel)
        
        let randomBtn = UIButton.init(frame: CGRect.init(x: 10, y: 20, width: 80, height: 50))
        randomBtn.setTitle("随机", for: UIControlState.normal)
        randomBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        randomBtn.addTarget(self, action: #selector(randomBtnClicked), for: UIControlEvents.touchUpInside)
        headerView.addSubview(randomBtn)
    
        self.view.addSubview(headerView)
        
        pickerView.frame = CGRect.init(x: 0, y: 80, width: screenWidth, height: 200)
        pickerView.dataSource = self
        pickerView.delegate = self
        self.view.addSubview(pickerView)
        
        fruitLabel.frame = CGRect.init(x: 20, y: 300, width: 250, height: 50)
        self.view.addSubview(fruitLabel)
        foodLabel.frame = CGRect.init(x: 20, y: 350, width: 250, height: 50)
        self.view.addSubview(foodLabel)
        drinkLabel.frame = CGRect.init(x: 20, y: 400, width: 250, height: 50)
        self.view.addSubview(drinkLabel)
        
        for i in 0...(foods.count-1) {
            self.pickerView(pickerView, didSelectRow: 0, inComponent: i)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return foods.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (foods[component] as! NSArray).count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let items = foods[component] as! NSArray
        return items[row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let items = foods[component] as! NSArray
        let item = items[row] as! String
        switch component {
        case 0:
            fruitLabel.text = "水果：" + item
            break
        case 1:
            foodLabel.text = "主食：" + item
            break
        case 2:
            drinkLabel.text = "饮料：" + item
        default:
            break
        }
    }
    
    @objc func randomBtnClicked() {
        for i in 0...(foods.count-1) {
            let items = foods[i] as! NSArray
            var randomRow = Int(arc4random_uniform(UInt32(items.count)))
            let oldRow = pickerView.selectedRow(inComponent: i)
            while (randomRow == oldRow) {
                randomRow = Int(arc4random_uniform(UInt32(items.count)))
            }
            
            // 更改pickerview中显示数据
            pickerView.selectRow(randomRow, inComponent: i, animated: true)
            // 更改label显示数据
            self.pickerView(pickerView, didSelectRow: randomRow, inComponent: i)
        }
    }
}

