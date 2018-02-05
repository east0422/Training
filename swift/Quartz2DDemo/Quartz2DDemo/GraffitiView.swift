//
//  GraffitiView.swift
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-5.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class GraffitiView: UIView {
    
    lazy var lines:[UIBezierPath] = []  // 每个数组对应组成一条线
    lazy var lineColors:[UIColor] = [] // 对应线的颜色
    var curLineColor = UIColor.black
    
    
    override func draw(_ rect: CGRect) {
        for path in lines {
            // 设置颜色
            let color:UIColor = lineColors[lines.index(of: path)!]
            color.set()
            
            // 连接样式
            path.lineJoinStyle = CGLineJoin.round
            // 首尾样式
            path.lineCapStyle = CGLineCap.round
            // 宽度
            path.lineWidth = 2
            // 渲染
            path.stroke()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let berierPath = UIBezierPath.init()
        // 获取第一个触摸点在当前视图中的位置点
        let point = touches.first?.location(in: self)
        berierPath.move(to: point!)
        // 触摸开始时创建一条线添加到数组中
        lines.append(berierPath)
        // 添加当然线绘制颜色到颜色数组中
        lineColors.append(curLineColor)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.last?.addLine(to: (touches.first?.location(in: self))!)
        // 重绘
        setNeedsDisplay()
    }
    
    // 回退，删除最后绘制的一条线
    @objc func back() {
        lines.removeLast()
        lineColors.removeLast()
        setNeedsDisplay()
    }
    
    // 清除所有的
    @objc func clear() {
        lines.removeAll()
        lineColors.removeAll()
        setNeedsDisplay()
    }
    
    // 将当前绘制图画保存到相册
    @objc func saveToAlbum() {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, self, nil, nil)
    }
}
