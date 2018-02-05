//
//  ViewController.swift
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-2.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LockViewProtocol {
    
    let progressCircle = ProgressCircleView.init()
    let waterImageView = UIImageView.init()
    let graffitiView = GraffitiView.init()
    let colorBtn = UIButton.init(type: UIButtonType.system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        // CustomView
//        let customView = CustomView.init(frame: self.view.frame)
//        customView.backgroundColor = UIColor.clear
//        self.view.addSubview(customView)
        
        // HuangView
//        let huang = HuangView.init(frame: self.view.frame)
//        huang.backgroundColor = UIColor.clear
//        self.view.addSubview(huang)
        
        // PieView
//        let pie = PieView.init(frame: self.view.frame)
//        pie.backgroundColor = UIColor.clear
//        pie.sections = [20, 30, 10, 40, 20]
//        pie.sectionColors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.brown, UIColor.cyan]
//        self.view.addSubview(pie)
        
        // ProgressCircleView
//       progressCircle.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: self.view.frame.size.width, height: self.view.frame.size.height - 100))
//        progressCircle.backgroundColor = UIColor.clear
//        self.view.addSubview(progressCircle)
//        let slider = UISlider.init(frame: CGRect.init(x: 20, y: self.view.frame.size.height - 80, width: self.view.frame.size.width - 40, height: 30))
//        slider.minimumValue = 0
//        slider.maximumValue = 1
//        slider.setValue(0, animated: true)
//        slider.addTarget(self, action: #selector(sliderValueChanged(slider:)), for: UIControlEvents.valueChanged)
//        self.view.addSubview(slider)
        
        // SnowView
//        let snow = SnowView.init(frame: self.view.frame)
//        snow.backgroundColor = UIColor.clear
//        self.view.addSubview(snow)
        
        // WaterImageView
//        waterImageView.frame = self.view.frame
//        waterImageView.image = UIImage.init(named: "papa")
//        self.view.addSubview(waterImageView)

        // ScreenshotsView
//        let screenshots = ScreenshotsView.init(frame: self.view.frame)
//        screenshots.backgroundColor = UIColor.blue
//        self.view.addSubview(screenshots)
        
        // GraffitiView
//        self.testGraffitiView()
        
        // LockView
        let lock = LockView.init(frame: self.view.frame)
        lock.delegete = self
        // 设置背景图片
        lock.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "gesture_bg")!)
        self.view.addSubview(lock)
    }
    
    // test for ProgressCircleView
    @objc func sliderValueChanged(slider: UISlider) {
        progressCircle.progress = slider.value
        progressCircle.setNeedsDisplay()
    }
    
    // test for WaterImageView
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (waterImageView.image == UIImage.init(named: "papa")) {
            let waterImage = WaterImageView.waterImageWith(bgImageName: "papa", waterImageName: "snow", scale: 0.8)
            waterImageView.image = waterImage
        } else {
            waterImageView.image = UIImage.init(named: "papa")
        }
    }
    
    func testGraffitiView() {
        let size = self.view.frame.size
        let marginLeft:CGFloat = 20
        let marginTop:CGFloat = 50
        let btnWidth = (size.width - marginLeft * 4) / 3
        let btnHeight:CGFloat = 50
        
        let backBtn = UIButton.init(type: UIButtonType.system)
        backBtn.frame = CGRect.init(x: marginLeft, y: marginTop, width: btnWidth, height: btnHeight)
        backBtn.setTitle("返回", for: UIControlState.normal)
        backBtn.backgroundColor = UIColor.cyan
        backBtn.addTarget(graffitiView, action: #selector(graffitiView.back), for: UIControlEvents.touchUpInside)
        self.view.addSubview(backBtn)
        
        let clearBtn = UIButton.init(type: UIButtonType.system)
        clearBtn.frame = CGRect.init(x: marginLeft + (btnWidth + marginLeft), y: marginTop, width: btnWidth, height: btnHeight)
        clearBtn.setTitle("清除", for: UIControlState.normal)
        clearBtn.backgroundColor = UIColor.cyan
        clearBtn.addTarget(graffitiView, action: #selector(graffitiView.clear), for: UIControlEvents.touchUpInside)
        self.view.addSubview(clearBtn)
        
        let saveBtn = UIButton.init(type: UIButtonType.system)
        saveBtn.frame = CGRect.init(x: marginLeft + (btnWidth + marginLeft) * 2, y: marginTop, width: btnWidth, height: btnHeight)
        saveBtn.setTitle("保存", for: UIControlState.normal)
        saveBtn.backgroundColor = UIColor.cyan
        saveBtn.addTarget(graffitiView, action: Selector(("saveToAlbum")), for: UIControlEvents.touchUpInside)
        self.view.addSubview(saveBtn)
        
        graffitiView.frame = CGRect.init(x: 10, y: marginTop + btnHeight + 30, width: size.width - 20, height: 280)
        graffitiView.backgroundColor = UIColor.gray
        self.view.addSubview(graffitiView)
        
        colorBtn.frame = CGRect.init(x: (size.width - 100)/2, y: size.height - 80, width: 100, height: 50)
        colorBtn.setTitle("随机更改颜色", for: UIControlState.normal)
        colorBtn.backgroundColor = UIColor.black
        colorBtn.addTarget(self, action: #selector(colorBtnClicked), for: UIControlEvents.touchUpInside)
        self.view.addSubview(colorBtn)
    }
    
    // test for GraffitiView
    @objc func colorBtnClicked() {
        let r = CGFloat(arc4random() % 256) / 255.0
        let g = CGFloat(arc4random() % 256) / 255.0
        let b = CGFloat(arc4random() % 256) / 255.0
        let color = UIColor.init(red: r, green: g, blue: b, alpha: 1.0)
        graffitiView.curLineColor = color
        colorBtn.backgroundColor = color
    }

    // test for LockView
    func unlockWithPassword(password: String) {
        print("password:" + password)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

