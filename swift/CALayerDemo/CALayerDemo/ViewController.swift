//
//  ViewController.swift
//  CALayerDemo
//
//  Created by dfang on 2018-3-5.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var cusView = UIView.init(frame: CGRect.init(x: 80, y: 80, width: 150, height: 150))
    lazy var subLayer = CALayer.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 基本属性测试
        //        self.testBasicAttr()
        
        // 锚点和位置测试
        //        self.testPostionAnchor()
        
        // 图片裁剪并设置阴影测试
        //        self.testCropImage()
        
        // 自定义图层测试
        //        self.testCustomLayer()
        
        // 自定义view测试旋转/平移/缩放
        //        cusView.layer.contents = UIImage.init(named: "img_01")?.cgImage
        //        self.view.addSubview(cusView)
        
        // 隐式动画，只有非根层(控件的layer属性的子层sublayers)才有隐式动画，根层(控件的layer属性)没有隐式动画
        subLayer.contents = UIImage.init(named: "img_01")?.cgImage
        subLayer.bounds = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 100, height: 100))
        subLayer.position = CGPoint.init(x: 150, y: 250)
        subLayer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        self.view.layer.addSublayer(subLayer)
    }
    
    // 图层基本属性测试
    func testBasicAttr() {
        let cusView = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 200, height: 150))
        // 背景颜色
        cusView.backgroundColor = UIColor.red
        
        let layer = CALayer.init()
        // 图层尺寸，bounds设置当前视图左上角(默认为(0,0))相对子视图的坐标点,注意layer默认position为(0,0), anchorPoint为(0.5,0.5)
        layer.bounds = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 150, height: 150))
        // 图层透明度
        layer.opacity = 0.5
        // 图层背景颜色
        layer.backgroundColor = UIColor.green.cgColor
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        // 剪掉圆角周边
        //    layer.masksToBounds = YES
        
        // 阴影
        layer.shadowColor = UIColor.blue.cgColor
        layer.shadowOpacity = 0.5
        // 设置阴影偏移位置，默认为(0,0)
        layer.shadowOffset = CGSize.init(width: 30, height: 30)
        layer.shadowRadius = 10
        layer.contents = UIImage.init(named: "img_01")?.cgImage
        
        // 若想圆角周边和阴影同时存在则使用圆角图片再设置阴影即可
        
        cusView.layer.addSublayer(layer)
        self.view.addSubview(cusView)
    }
    
    // 图层位置和锚点测试
    func testPostionAnchor () {
        let layer = CALayer.init()
        layer.backgroundColor = UIColor.red.cgColor
        layer.bounds = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 100, height: 100))
        // 图层的透明度
        layer.opacity = 0.5
        
        // 设置位置
        layer.position = CGPoint.init(x: 100, y: 100)
        // 设置锚点
        layer.anchorPoint = CGPoint.init(x: 0, y: 0.5)
        
        // 然后添加到控制器的view的图层
        self.view.layer.addSublayer(layer)
    }
    
    // 裁剪圆角图片并加阴影
    func testCropImage () {
        let imageView = UIImageView.init(frame: CGRect.init(x: 80, y: 80, width: 150, height: 150))
        let cropImage = UIImage.crop(imageName: "img_01", cornerRadius: 10, borderWidth: 2, borderColor: UIColor.blue)
        
        // 设置圆角图片
        imageView.image = cropImage
        // 设置阴影
        imageView.layer.shadowColor = UIColor.black.cgColor
        // 阴影偏移位置，默认为(0,0)
        imageView.layer.shadowOffset = CGSize.init(width: 30, height: 30)
        imageView.layer.shadowOpacity = 0.7
        imageView.layer.shadowRadius = 15
        
        self.view.addSubview(imageView)
    }
    
    // 自定义图层
    func testCustomLayer () {
        let layer = CustomLayer.init()
        layer.backgroundColor = UIColor.red.cgColor
        layer.bounds = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 150, height: 150))
        
        // 自定义的图层在drawInContext绘制的东西若要显示则必须手动调用setNeedsDisplay
        layer.setNeedsDisplay()
        
        layer.position = CGPoint.init(x: 150, y: 150)
        layer.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        
        self.view.layer.addSublayer(layer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 测试旋转/平移/缩放
        //        self.testTransform()
        // 隐式动画
        self.testImplicitAnimation()
    }
    
    // 转换
    func testTransform() {
        let transform = cusView.layer.transform;
        // 缩放
        //        cusView.layer.transform = CATransform3DScale(transform, 1.1, 1.1, 1)
        // 旋转
        //        cusView.layer.transform = CATransform3DRotate(transform, CGFloat(M_PI_4 / 4), 1, 1, 1)
        // 平移
        //        cusView.layer.transform = CATransform3DTranslate(transform, 10, 10, 0)
        
        
        // kvc forKey
        // 缩放
        //        cusView.layer.setValue(NSValue.init(caTransform3D: CATransform3DScale(transform, 1.1, 1.1, 1)), forKey: "transform")
        // 其他key也可以,bounds更改大小及位置
        //        cusView.layer.setValue(NSValue.init(cgRect: CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: 200, height: 300))), forKey: "bounds")
        
        
        // kvc forKeyPath
        // m11: X方向缩放，m22: Y方向缩放, M33: Z方向缩放
        // m41: X方向平移，m42: Y方向平移，m43: Z方向平移
        // 旋转和多个值相关不建议使用m
        //        cusView.layer.setValue(transform.m11 * 1.1, forKeyPath: "transform.scale.x")
        //        cusView.layer.setValue(transform.m42 + 20, forKeyPath: "transform.translation.y")
        //        cusView.layer.setValue(Float.pi / 4, forKeyPath: "transform.rotation.y")
        //        cusView.layer.setValue(NSValue.init(cgPoint: CGPoint.init(x: 10, y: 20)), forKeyPath: "transform.translation")
        cusView.layer.setValue(NSValue.init(caTransform3D: CATransform3DRotate(transform, CGFloat(Float.pi / 4 * 0.2), 1, 1, 1)), forKeyPath: "transform")
    }
    
    // 隐式动画，只有非根层(控件的layer属性的子层sublayers)才有隐式动画，根层(控件的layer属性)没有隐式动画
    func testImplicitAnimation() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(5)
        subLayer.transform = CATransform3DRotate(cusView.layer.transform, CGFloat(Double.pi / 4), 1, 1, 1)
        CATransaction.commit()
    }
}
