//
//  HuangView.swift
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-2.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class HuangView: UIView {
    
    lazy var context = UIGraphicsGetCurrentContext()
    
    override func draw(_ rect: CGRect) {
        let marginTop:CGFloat = 50
        let radius:CGFloat = 100
        let middleH:CGFloat = 200
        
        // 设置黄色,绘制顶部，身体，底部
        context?.setFillColor(UIColor.yellow.cgColor)
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5, y: marginTop + radius), radius: CGFloat(radius), startAngle: 0, endAngle: CGFloat(Float.pi), clockwise: true)
        context?.addRect(CGRect.init(x: rect.width * 0.5 - radius, y: marginTop + radius, width: radius * 2, height: middleH))
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5, y: marginTop + radius + middleH), radius: radius, startAngle: 0, endAngle: CGFloat(Float.pi), clockwise: false)
        context?.fillPath()
        
        // 设置黑色，绘制眼眶
        context?.setFillColor(UIColor.black.cgColor)
        let padding:CGFloat = 5
        let glassH:CGFloat = 30
        context?.addRect(CGRect.init(x: rect.width * 0.5 - radius - padding, y: marginTop + radius, width: (radius + padding) * 2, height: glassH))
        context?.fillPath()
        
        // 设置白色，绘制大眼睛
        context?.setFillColor(UIColor.white.cgColor)
        let whiteRadius = radius * 0.3
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5 - whiteRadius, y: marginTop + radius + glassH * 0.5), radius: whiteRadius, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: false)
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5 + whiteRadius, y: marginTop + radius + glassH * 0.5), radius: whiteRadius, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: false)
        context?.fillPath()
        
        // 设置黑色，绘制黑眼圈
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(10)
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5 - whiteRadius, y: marginTop + radius + glassH * 0.5), radius: whiteRadius, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: false)
        context?.move(to: CGPoint.init(x: rect.width * 0.5 + whiteRadius * 2, y: marginTop + radius + glassH * 0.5))
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5 + whiteRadius, y: marginTop + radius + glassH * 0.5), radius: whiteRadius, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: false)
        context?.strokePath()
        
        // 设置棕色，绘制眼球
        context?.setFillColor(UIColor.brown.cgColor)
        let eyeballRadius = radius * 0.15
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5 - whiteRadius, y: marginTop + radius + glassH * 0.5), radius: eyeballRadius, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: false)
        context?.move(to: CGPoint.init(x: rect.width * 0.5 + eyeballRadius * 2, y: marginTop + radius + glassH * 0.5))
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5 + whiteRadius, y: marginTop + radius + glassH * 0.5), radius: eyeballRadius, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: false)
        context?.fillPath()
        
        // 设置白色，绘制眼珠
        context?.setFillColor(UIColor.white.cgColor)
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5 - whiteRadius, y: marginTop + radius + glassH * 0.5 - 5), radius: eyeballRadius * 0.2, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: false)
        context?.move(to: CGPoint.init(x: rect.width * 0.5 + whiteRadius, y: marginTop + radius + glassH * 0.5 - 5))
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5 + whiteRadius, y: marginTop + radius + glassH * 0.5 - 5), radius: eyeballRadius * 0.2, startAngle: 0, endAngle: CGFloat(Float.pi * 2), clockwise: false)
        context?.fillPath()
        
        // 设置黑色，绘制嘴巴
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.setLineWidth(2)
        context?.addArc(center: CGPoint.init(x: rect.width * 0.5, y: marginTop + radius * 2), radius: 50, startAngle: CGFloat(Float.pi/4), endAngle: CGFloat(Float.pi/4 * 3), clockwise: false)
        context?.strokePath()
    }
}
