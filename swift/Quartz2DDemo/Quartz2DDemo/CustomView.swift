//
//  CustomView.swift
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-2.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class CustomView: UIView {
    // 懒加载上下文
    lazy var context = UIGraphicsGetCurrentContext()
    
    override func draw(_ rect: CGRect) {
//        self.drawLine()
//        self.drawPolygon()
//        self.drawArc()
//        self.drawSector()
//        self.drawText()
//        self.drawRotate()
//        self.clipImage()
        
        // UIKit的方法不用获取上下文，但内部会获取上下文进行绘制
//        //画实心
//        UIRectFill(CGRect.init(x: 50, y: 50, width: 100, height: 100));
//        //画空心
//        UIRectFrame(CGRect.init(x: 50, y: 180, width: 80, height: 80));

        self.drawPath()
    }
    
    // 绘制线条
    func drawLine() {
        // 设置起点
        context?.move(to: CGPoint.init(x: 10, y: 100))
        // 设置线宽
        context?.setLineWidth(12)
        // 设置头尾样式
        context?.setLineCap(CGLineCap.round)
        // 设置连接点样式
        context?.setLineJoin(CGLineJoin.round)
        // 从当前点绘制直线到制定点
        context?.addLine(to: CGPoint.init(x: 80, y: 200))
        context?.strokePath()
        
        // 将当前上下文保存到栈中
        context?.saveGState()
        
        // 设置绘制颜色
        context?.setStrokeColor(UIColor.red.cgColor)
        // 设置线宽
        context?.setLineWidth(8)
        // 设置连接点样式
        context?.setLineJoin(CGLineJoin.bevel)
        // 绘制线需要一个起点
        context?.move(to: CGPoint.init(x: 80, y: 200))
        context?.addLine(to: CGPoint.init(x: 150, y: 80))
        context?.strokePath()
        
        // 恢复当前上下文，栈顶上下文出栈
        context?.restoreGState()
        
        // 绘制线需要一个起点
        context?.move(to: CGPoint.init(x: 150, y: 80))
        context?.addLine(to: CGPoint.init(x: 200, y: 120))
        // 绘制线条
        context?.strokePath()
    }
    
    // 绘制多边形
    func drawPolygon() {
        // 顺序连接所有点
        context?.addLines(between: [CGPoint.init(x: 150, y: 80),
                                    CGPoint.init(x: 280, y: 200),
                                    CGPoint.init(x: 180, y: 240),
                                    CGPoint.init(x: 100, y: 100)])
        // 关闭路径，要想组成环则需要添加一个和起点重合的终点
        context?.closePath()
        // 实心图形
//        context?.fillPath()
        // 渲染
        context?.strokePath()
    }
    
    // 绘制弧线
    func drawArc() {
        let center = CGPoint.init(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5 - 150)
        context?.addArc(center: center, radius: 100, startAngle: CGFloat(Double.pi/4), endAngle: CGFloat(3 * Double.pi/4), clockwise: false)
        context?.strokePath()
    }
    
    // 绘制扇形
    func drawSector() {
        let center = CGPoint.init(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5 - 150)
        context?.move(to: center)
        context?.addArc(center: center, radius: 100, startAngle: CGFloat(Double.pi/4), endAngle: CGFloat(3 * Double.pi/4), clockwise: false)
        // 实心扇形
//        context?.fillPath()
        // 空心扇形
        context?.closePath()
        context?.strokePath()
    }
    
    // 绘制文字
    func drawText() {
        let text = "放假了回家过年了，没钱了，南大909102，年初年尾都一样，几家欢喜几家愁，多拿钱多干活"
        (text as NSString).draw(in: CGRect.init(origin: CGPoint.init(x: 20, y: 50), size: CGSize.init(width: self.frame.size.width - 40, height: self.frame.size.height * 0.5)), withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15),NSAttributedStringKey.foregroundColor: UIColor.green])
    }
    
    // 平移/缩放/旋转, 需在绘制前操作
    func drawRotate() {
        let centerX = self.frame.size.width * 0.5
        let padding:CGFloat = 30
        // 画一个三角形
        context?.addLines(between: [CGPoint.init(x: centerX - padding, y: 200), CGPoint.init(x: centerX, y: 100), CGPoint.init(x: centerX + padding, y: 200)])
        context?.closePath()
        // 画一条直线做参考
        context?.addLines(between: [CGPoint.init(x: centerX, y: 100), CGPoint.init(x: centerX, y: 200)])
        context?.strokePath()
        
        // 平移
        context?.translateBy(x: 300, y: 100)
        // 缩放
        context?.scaleBy(x: 0.5, y: 1.0)
        // 旋转, 绕着左上角原点（0,0)旋转
        context?.rotate(by: CGFloat(Double.pi/2))
        
        context?.setStrokeColor(UIColor.red.cgColor)
        // 画一个三角形
        context?.move(to: CGPoint.init(x: centerX - padding, y: 200))
       context?.addLines(between: [CGPoint.init(x: centerX - padding, y: 200), CGPoint.init(x: centerX, y: 100), CGPoint.init(x: centerX + padding, y: 200)])
        context?.closePath()
        // 画一条直线做参考
        context?.addLines(between: [CGPoint.init(x: centerX, y: 100), CGPoint.init(x: centerX, y: 200)])
        context?.strokePath()
    }
    
    // 图片裁剪
    func clipImage() {
        context?.addEllipse(in: self.frame)
        context?.clip()
        let image = UIImage.init(named: "papa")
        image?.draw(in: self.frame)
        context?.setStrokeColor(UIColor.yellow.cgColor)
        context?.setLineWidth(10)
        context?.addEllipse(in: self.frame)
        context?.strokePath()
    }
    
    // 使用path
    func drawPath() {
        let path = CGMutablePath.init()
        path.addRect(CGRect.init(x: 80, y: 80, width: 100, height: 100))
        path.addEllipse(in: CGRect.init(x: 80, y: 200, width: 100, height: 100))
        path.move(to: CGPoint.init(x: 80, y: 310))
        path.addCurve(to: CGPoint.init(x: 80, y: 310), control1: CGPoint.init(x: 100, y: 400), control2: CGPoint.init(x: 280, y: 350))
        context?.addPath(path)
        context?.strokePath()
    }
}
