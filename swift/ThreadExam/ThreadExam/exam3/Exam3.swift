//
//  Exam3.swift
//  ThreadExam
//
//  Created by dfang on 2018-5-8.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class Exam3: UIViewController {
    
    let clockImageView = UIImageView.init(image: UIImage.init(named: "clock"))
    lazy var layerSec: CALayer = {
        return layerWith(backgroungColor: UIColor.red, size: CGSize.init(width: 2, height: 100))
    }()
    
    lazy var layerMinute: CALayer = {
        return layerWith(backgroungColor: UIColor.brown, size: CGSize.init(width: 3, height: 80))
    }()
    
    lazy var layerHour: CALayer = {
        return layerWith(backgroungColor: UIColor.black, size: CGSize.init(width: 5, height: 60))
    }()
    
    override func viewDidLoad() {
        clockImageView.center = self.view.center
        self.view.addSubview(clockImageView)
        
        clockImageView.layer.addSublayer(layerSec)
        clockImageView.layer.addSublayer(layerMinute)
        clockImageView.layer.addSublayer(layerHour)
        
//        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateUI), userInfo: nil, repeats: true)
//        RunLoop.current.add(timer, forMode: RunLoopMode.defaultRunLoopMode)
        
        let link = CADisplayLink.init(target: self, selector: #selector(updateUI))
        // 启动这个link
        link.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    // 创建图层
    func layerWith(backgroungColor:UIColor, size: CGSize) -> CALayer {
        let layer = CALayer.init()
        layer.backgroundColor = backgroungColor.cgColor
        layer.anchorPoint = CGPoint.init(x: 0.5, y: 1)
        layer.position = CGPoint.init(x: clockImageView.frame.size.width/2, y: clockImageView.frame.size.height/2)
        layer.bounds = CGRect.init(origin: CGPoint.zero, size: size)
        layer.cornerRadius = 5
        return layer
    }
    
    // 更新时针、分针、秒针
    @objc func updateUI() {
        DispatchQueue.global().async {
            DispatchQueue.main.async(execute: {
                let curComps = Calendar.current.dateComponents([Calendar.Component.hour,
                                                                Calendar.Component.minute,
                                                                Calendar.Component.second],
                                                               from: Date())
                let secAngle = Float(curComps.second!) * (Float.pi * 2 / 60)
                let minuteAngle = Float(curComps.minute!) * (Float.pi * 2 / 60) + (secAngle / 60)
                let hourAngle = Float(curComps.hour!) * (Float.pi * 2 / 12) + (minuteAngle / 12)
                self.layerSec.transform = CATransform3DMakeRotation(CGFloat(secAngle), 0, 0, 1)
                self.layerMinute.transform = CATransform3DMakeRotation(CGFloat(minuteAngle), 0, 0, 1)
                self.layerHour.transform = CATransform3DMakeRotation(CGFloat(hourAngle), 0, 0, 1)
            })
        }
    }
}
