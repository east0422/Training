//
//  SummaryViewController.swift
//  AnimationDemo
//
//  Created by dfang on 2018-3-22.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController, CAAnimationDelegate {
    
    lazy var imageView = UIImageView.init(image: UIImage.init(named: "image"))
    let btnTitles = ["uiview", "uiview块", "uiview转场", "animation"]
    let btnColumnCount = 3
    let animationDuration:TimeInterval = 3
    
    override func viewDidLoad() {
        navigationItem.title = "动画总结"
        
        imageView.frame = CGRect.init(origin: CGPoint.init(x: (view.frame.size.width - imageView.frame.size.width)/2, y: 80), size: imageView.frame.size)
        view.addSubview(imageView)
        createTestBtns()
    }
    
    // 每行显示3个按钮
    func createTestBtns() {
        let width:CGFloat = 100
        let height:CGFloat = 60
        let padding:CGFloat = (view.frame.size.width - width * CGFloat(btnColumnCount)) / CGFloat((btnColumnCount + 1))
        var x:CGFloat = padding
        let extraHeight = height + padding + ((tabBarController != nil) ? (tabBarController?.tabBar.frame.size.height)! : CGFloat(0))
        var y:CGFloat = view.frame.size.height - extraHeight
        let btnrows = btnTitles.count / btnColumnCount + ((btnTitles.count % btnColumnCount != 0) ? 1 : 0)
        
        for (index, title) in btnTitles.enumerated() {
            x = padding + CGFloat(index % btnColumnCount) * (width + padding)
            y = view.frame.size.height - extraHeight - CGFloat(btnrows - 1 - (index / btnColumnCount)) * (height + padding)
            let btn = UIButton.init(frame: CGRect.init(x: x, y: y, width: width, height: height))
            btn.tag = index
            btn.setTitle(title, for: UIControlState.normal)
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.backgroundColor = UIColor.white
            btn.layer.borderColor = UIColor.lightGray.cgColor
            btn.layer.borderWidth = 2
            btn.layer.cornerRadius = 10
            btn.addTarget(self, action: #selector(btnClicked(btn:)), for: UIControlEvents.touchUpInside)
            view.addSubview(btn)
        }
    }
    
    @objc func btnClicked(btn: UIButton) {
        switch btn.tag {
        case 0:
            testView1()
            break
        case 1:
            testView2()
            break
        case 2:
            testViewTransition()
            break
        case 3:
            testAnimation()
            break
        default:
            print("default")
        }
    }
    
    // 使用UIView普通动画
    func testView1() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(animationDuration)
        
        // 设置代理方法
        UIView.setAnimationDelegate(self)
        UIView.setAnimationDidStop(#selector(stop))
        
        imageView.center = CGPoint.init(x: 100, y: 400)
        UIView.commitAnimations()
    }
    
    func testView2() {
        UIView.animate(withDuration: animationDuration, animations: {
            self.imageView.center = CGPoint.init(x: 200, y: 300)
        }) { (finished) in
            self.stop()
        }
    }
    
    func testViewTransition() {
        UIView.transition(with: imageView, duration: animationDuration, options: UIViewAnimationOptions.transitionFlipFromLeft, animations: {
            self.imageView.image = UIImage.init(named: "2")
        }) { (finished) in
            self.stop()
        }
    }
    
    func testAnimation() {
        let animation = CABasicAnimation.init(keyPath: "position")
        animation.toValue = NSValue.init(cgPoint: CGPoint.init(x: 80, y: 100))
        animation.duration = animationDuration
        
        // 动画结束后动画状态保持结束时状态，但实际上位置等属性已恢复初始状态
        // 是个假象，如使用removeAnimation后再开始新的动画会看到新动画开始状态和本动画开始前状态一致
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        
        animation.delegate = self
        imageView.layer.add(animation, forKey: nil)
    }

    // 核心动画代理方法，设置animation的代理
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        stop()
    }
    
    // 结束动画
    @objc func stop() {
        print("动画结束")
    }
}
