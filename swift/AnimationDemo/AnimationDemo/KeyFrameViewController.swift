//
//  KeyFrameViewController.swift
//  AnimationDemo
//
//  Created by dfang on 2018-3-19.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class KeyFrameViewController: UIViewController {
    let redView = UIView.init()
    let radius = 150
    let left = 10
    let top = 100
    let redRadius = 10
    
    override func viewDidLoad() {
        navigationItem.title = "帧动画演示"
        let circle = UIView.init(frame: CGRect.init(x: left, y: top, width: radius * 2, height: radius * 2))
        circle.backgroundColor = UIColor.lightGray
        circle.layer.cornerRadius = CGFloat(radius)
        view.addSubview(circle)
        
        redView.frame = CGRect.init(x: radius + left - redRadius, y: top - redRadius, width: redRadius * 2, height: redRadius * 2)
        redView.backgroundColor = UIColor.red
        view.addSubview(redView)
        
        let btn = UIButton.init(frame: CGRect.init(x: (view.frame.size.width - 100)/2, y: view.frame.size.height - 120, width: 100, height: 40))
        btn.setTitle("keyframe", for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.borderWidth = 2
        btn.addTarget(self, action: #selector(testKeyFrame), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
    }
    
    @objc func testKeyFrame() {
        // 帧动画
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        
        let values1 = NSValue.init(cgPoint: CGPoint.init(x: radius + left, y: top))
        let values2 = NSValue.init(cgPoint: CGPoint.init(x: radius * 2 + left, y: top + radius))
        let values3 = NSValue.init(cgPoint: CGPoint.init(x: radius + left, y: top + radius * 2))
        let values4 = NSValue.init(cgPoint: CGPoint.init(x: left, y: top + radius))
        animation.values = [values1, values2, values3, values4, values1]
        
        // 设置animation的path后会忽略values值
        // If you specify a value for this property, any data in the values property is ignored
        let path = CGMutablePath.init()
        path.addArc(center: CGPoint.init(x: radius + left, y: radius + top), radius: CGFloat(radius), startAngle: CGFloat(-Float.pi / 2), endAngle: CGFloat(Float.pi / 2 * 3), clockwise: false)
        // 默认起点在最右侧(radius * 2 + left, radius + top)
//        path.addEllipse(in: CGRect.init(x: left, y: top, width: radius * 2, height: radius * 2))
        animation.path = path
        
        // 动画持续时间
        animation.duration = 5
        // 动画一直进行下去直到调用removeAnimationForKey, key值应和添加时保持一致
//        animation.repeatCount = MAXFLOAT
        // 动画执行完成保持状态
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        // 设置动画效果
        animation.timingFunctions = [CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)]
        
        redView.layer.add(animation, forKey: nil)
    }
}
