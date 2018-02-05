//
//  SnowView.swift
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-3.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class SnowView: UIView {
    lazy var locations: [CGPoint] = {
        var _locations: [CGPoint] = []
        let marginLeft = 20
        let snowW = 40
        for var i in 0...6 {
            _locations.append(CGPoint.init(x: marginLeft + i * snowW, y: 50))
        }
        return _locations
    }()
    
    lazy var snowImage: UIImage = {
        return UIImage.init(named: "snow")
    }()!

    var timer:Timer?
    var displayLink:CADisplayLink?
    
    
    override func draw(_ rect: CGRect) {
        for index in 0...(locations.count-1) {
            var newPosition = locations[index]
            if (newPosition.y > rect.height) {
                newPosition.y = 50
            } else {
                newPosition.y += CGFloat(arc4random_uniform(10))
            }
            
            locations.replaceSubrange(Range(index...index), with: [newPosition])
            // 以图片大小显示
//            snowImage.draw(at: newPosition)
            // 图片大小缩放为30*30
            snowImage.draw(in: CGRect.init(origin: newPosition, size: CGSize.init(width: 30, height: 30)))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addAnimation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addAnimation() {
        // method 1.1
//        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (Timer) in
//            self.setNeedsDisplay()
//        });
//        method 1.2
//        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(reDraw), userInfo: nil, repeats: true)
        
        // method 2
        displayLink = CADisplayLink.init(target: self, selector: #selector(reDraw))
        displayLink?.preferredFramesPerSecond = 10
        displayLink?.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    @objc func reDraw() {
        self.setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // method 1
//        guard timer == nil else {
//            timer?.invalidate()
//            timer = nil
//            return
//        }
        
        // method 2
        guard displayLink == nil else {
            displayLink?.invalidate()
            displayLink = nil
            return
        }

        self.addAnimation()
    }
}
