//
//  ProgressCircleView.swift
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-3.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ProgressCircleView: UIView {
    
    var progress:Float = 0
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let text = String.init(format: "%d%%", Int(progress * 100))
        (text as NSString).draw(in: CGRect.init(x: rect.width * 0.5 - 20, y: rect.height * 0.5 - 10, width: 40, height: 20), withAttributes: nil)
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5, y: rect.height * 0.5), radius: min(rect.width, rect.height) * 0.4, startAngle: CGFloat(-Float.pi/2), endAngle: CGFloat(progress * Float.pi * 2 - Float.pi/2), clockwise: false)
        context?.strokePath()
    }
    
}
