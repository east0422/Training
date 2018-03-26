//
//  BasicAnimationViewController.swift
//  AnimationDemo
//
//  Created by dfang on 2018-3-19.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class BasicAnimationViewController: UIViewController {
    
    lazy var imageView = UIImageView.init(image: UIImage.init(named: "image"))
    let btnTitles = ["position", "translation", "rotation", "scale", "bounds"]
    let btnColumnCount = 3
    
    override func viewDidLoad() {
        navigationItem.title = "基本动画演示"
        // 添加图片
        imageView.frame = CGRect.init(x: (view.frame.size.width - imageView.frame.width)/2, y: 80, width: imageView.frame.width, height: imageView.frame.height)
        view.addSubview(imageView)
        // 创建测试按钮
        createTestBtns()
    }
    
    // 每行显示3个按钮
    func createTestBtns() {
        let width:CGFloat = 100
        let height:CGFloat = 40
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
            testPosition()
            break
        case 1:
            testTransition()
            break
        case 2:
            testRotation()
            break
        case 3:
            testScale()
            break
        case 4:
            testBounds()
            break
        default:
            print("default")
        }
    }
    
    // 位置平移
    func testPosition() {
        // 创建动画对象并设置动画类型为"平移"
        let animation = CABasicAnimation.init(keyPath: "position")
    
        animation.fromValue = NSValue.init(cgPoint: CGPoint.init(x: 100, y: 100))
        animation.toValue = NSValue.init(cgPoint: CGPoint.init(x: 200, y: 200))
        animation.byValue = NSValue.init(cgPoint: CGPoint.init(x: 10, y: 10))
    
        // 动画结束后保持
//        animation.isRemovedOnCompletion = false
        // 默认值kCAFillModeRemoved动画完成后删除动画状态
        animation.fillMode = kCAFillModeRemoved
        imageView.layer.add(animation, forKey: nil)
    }
    
    func testTransition() {
        // 创建动画对象并设置动画类型为"平移"
        let animation = CABasicAnimation.init(keyPath: "transform.translation")
        animation.byValue = NSValue.init(cgPoint: CGPoint.init(x: 10, y: 10))
        
//        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        imageView.layer.add(animation, forKey: nil)
    }
    
    func testRotation() {
        // 创建动画对象并设置动画类型为"旋转"
        let animation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        animation.byValue = Double.pi / 4
        
//        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBackwards
        imageView.layer.add(animation, forKey: nil)
    }
    
    func testScale() {
        // 创建动画对象并设置动画类型为"缩放"
        let animation = CABasicAnimation.init(keyPath: "transform.scale.y")
        animation.byValue = 0.5
        
//        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeBoth
        imageView.layer.add(animation, forKey: nil)
    }
    
    func testBounds() {
        // 创建动画对象并设置动画类型为"平移"
        let animation = CABasicAnimation.init(keyPath: "bounds")
        animation.byValue = NSValue.init(cgRect: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        
//        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        imageView.layer.add(animation, forKey: nil)
    }
}
