//
//  AnimationGroupViewController.swift
//  AnimationDemo
//
//  Created by dfang on 2018-3-19.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class AnimationGroupViewController: UIViewController {
    
    lazy var imageView = UIImageView.init(image: UIImage.init(named: "image"))
    
    override func viewDidLoad() {
        navigationItem.title = "组动画演示"
        
        imageView.frame = CGRect.init(origin: CGPoint.init(x: 80, y: 150), size: imageView.frame.size)
        view.addSubview(imageView)
        
        let btn = UIButton.init(frame: CGRect.init(x: (view.frame.size.width - 100)/2, y: view.frame.size.height - 150, width: 100, height: 50))
        btn.setTitle("组动画测试", for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        btn.backgroundColor = UIColor.white
        btn.layer.borderColor = UIColor.gray.cgColor
        btn.layer.borderWidth = 2
        btn.addTarget(self, action: #selector(animationGroupClicked), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
    }
    
    // 组动画演示
    @objc func animationGroupClicked() {
        let animationGroup = CAAnimationGroup.init()
        
        let opacityKFAnimation = CAKeyframeAnimation.init(keyPath: "opacity")
        opacityKFAnimation.values = [1, 0.6, 0.2, 0, 0.4, 0.8, 1.0]
        
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation")
        rotationAnimation.byValue = Float.pi / 4
        
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 1.5
        
        let transitionAnimation = CABasicAnimation.init(keyPath: "transform.transition")
        transitionAnimation.fromValue = CGPoint.init(x: 100, y: 100)
        transitionAnimation.toValue = CGPoint.init(x: 200, y: 400)
        
        animationGroup.animations = [opacityKFAnimation, rotationAnimation, scaleAnimation, transitionAnimation]
        animationGroup.duration = 5
//        animationGroup.isRemovedOnCompletion = false
//        animationGroup.fillMode = kCAFillModeBoth
        animationGroup.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        
        imageView.layer.add(animationGroup, forKey: nil)
    }
}
