//
//  PieView.swift
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-3.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class PieView: UIView {
    var sections:[Int] = []
    var sectionColors:[UIColor] = []
    
    override func draw(_ rect: CGRect) {
        var sum = 0
        
        for section in sections {
            sum += section
        }
        
        let context = UIGraphicsGetCurrentContext()
        var startAngle = -CGFloat(Float.pi/4)
        var endAngle:CGFloat = 0
        let center = CGPoint.init(x: rect.width * 0.5, y: rect.height * 0.5)
        let radius = min(rect.width, rect.height) * 0.5
        
        for color in sectionColors {
            endAngle = CGFloat(sections[sectionColors.index(of: color)!]) / CGFloat(sum) * 2.0 * CGFloat(Float.pi) + startAngle
            context?.setFillColor(color.cgColor)
            context?.move(to: center)
            context?.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            context?.fillPath()
            startAngle = endAngle
        }
    }
    
}
