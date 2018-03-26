//
//  TransitionViewController.swift
//  AnimationDemo
//
//  Created by dfang on 2018-3-19.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {
    lazy var imageView = UIImageView.init(frame: UIScreen.main.bounds)
    lazy var pics: [String] = {
        var _pics: [String] = []
        for i in 1...9 {
            _pics.append("\(i)")
        }
        
        return _pics
    }()
    var index = 0
    
    override func viewDidLoad() {
        navigationItem.title = "转场动画演示"
        
        imageView.image = UIImage.init(named: pics[index])
        view.addSubview(imageView)
        
        let height = 40
        let width = 60
        let padding = (Int(view.frame.size.width) - width * 2) / 3
        let top = Int(view.frame.size.height) - height - 80
        let previousBtn = UIButton.init(frame: CGRect.init(x: padding, y: top , width: width, height: height))
        previousBtn.setTitle("上一张", for: UIControlState.normal)
        previousBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        previousBtn.layer.borderColor = UIColor.gray.cgColor
        previousBtn.layer.borderWidth = 1
        previousBtn.addTarget(self, action: #selector(previousImage), for: UIControlEvents.touchUpInside)
        view.addSubview(previousBtn)
        
        let nextBtn = UIButton.init(frame: CGRect.init(x: padding * 2 + width, y: top, width: width, height: height))
        nextBtn.setTitle("下一张", for: UIControlState.normal)
        nextBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        nextBtn.layer.borderColor = UIColor.gray.cgColor
        nextBtn.layer.borderWidth = 1
        nextBtn.addTarget(self, action: #selector(nextImage), for: UIControlEvents.touchUpInside)
        view.addSubview(nextBtn)
    }
    
    // 上一张图片
    @objc func previousImage() {
        if (index > 0) {
            index = index - 1
            imageView.image = UIImage.init(named: pics[index])
            
            // 添加转场动画
            let transition = CATransition.init()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            transition.duration = 3
            
            imageView.layer.add(transition, forKey: nil)
        }
    }
    
    // 下一张图片
    @objc func nextImage() {
        if (index < pics.count - 1) {
            index = index + 1
            
            imageView.image = UIImage.init(named: pics[index])
            
            // 添加转场动画
            let transition = CATransition.init()
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            // 逆时针旋转
//            transition.type = "rotate"
//            transition.subtype = "90cw"
            transition.duration = 3
            
            imageView.layer.add(transition, forKey: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint:CGPoint = touches.first!.location(in: view)
        if (touchPoint.x <= view.frame.size.width / 2) { // 点击左半屏幕，上一张图片
            previousImage()
        } else {
            nextImage()
        }
    }
}
