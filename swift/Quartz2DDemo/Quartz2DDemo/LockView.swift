//
//  LockView.swift
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-6.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

@objc protocol LockViewProtocol: NSObjectProtocol {
    @objc func unlockWithPassword(password: String);
}

class LockView: UIView {
    
    var delegete:LockViewProtocol?
    var btns:[UIButton] = []
    var selectedBtns:[UIButton] = []
    var lastPoint = CGPoint.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initBtns()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard selectedBtns.count > 0 else {
            return
        }
        let linePath = UIBezierPath.init()
        // 设置连接点样式
        linePath.lineJoinStyle = CGLineJoin.round
        // 设置首尾样式
        linePath.lineCapStyle = CGLineCap.round
        // 设置颜色
        UIColor.green.set()
        // 设置宽度
        linePath.lineWidth = 5
        var unselectedBtns = btns.filter { (btn) -> Bool in
            return !selectedBtns.contains(btn)
        }
        linePath.move(to: selectedBtns[0].center)
        for selectbtn in selectedBtns {
            linePath.addLine(to: selectbtn.center)
            // 设置下一条线的起点
            linePath.move(to: selectbtn.center)
            // 增加跨越的点
            for unselectbtn in unselectedBtns {
                if (linePath.contains(unselectbtn.center)) {
                    unselectbtn.isSelected = true
                    selectedBtns.insert(unselectbtn, at: selectedBtns.index(of: selectbtn)!)
                    unselectedBtns.remove(at: unselectedBtns.index(of: unselectbtn)!)
                }
            }
        }
        linePath.addLine(to: lastPoint)
        
        linePath.stroke()
    }
    
    func initBtns() {
        let btnWidth:CGFloat = 74
        let btnHeight:CGFloat = 74
        let padding = (self.frame.size.width - btnWidth * 3) / 4
        let marginTop = (self.frame.size.height - self.frame.size.width) / 2
        for i in 0...8 {
            let btn = UIButton.init(type: UIButtonType.custom)
            btn.tag = i
            btn.frame = CGRect.init(x: padding + (btnWidth + padding) * CGFloat(i % 3), y: marginTop + padding + (btnHeight + padding) * CGFloat(i / 3), width: btnWidth, height: btnHeight)
            btn.setImage(UIImage.init(named: "gesture_node_normal"), for: UIControlState.normal)
            btn.setImage(UIImage.init(named: "gesture_node_highlighted"), for: UIControlState.selected)
            btn.isUserInteractionEnabled = false
            self.addSubview(btn)
            btns.append(btn)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        for btn in btns {
            if (btn.frame.contains(touchPoint!)) {
                if (btn.isSelected == false && !selectedBtns.contains(btn)) {
                    selectedBtns.append(btn)
                }
                btn.isSelected = true
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        for btn in btns {
            if (btn.frame.contains(touchPoint!)) {
                if (btn.isSelected == false && !selectedBtns.contains(btn)) {
                    selectedBtns.append(btn)
                }
                btn.isSelected = true
            } else {
                lastPoint = touchPoint!
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var password = ""
        selectedBtns.forEach { (btn) in
            btn.isSelected = false
            password.append(String(btn.tag))
        }
        selectedBtns.removeAll()
        if (delegete?.responds(to: #selector(LockViewProtocol.unlockWithPassword(password:))))! {
            delegete?.unlockWithPassword(password: password)
        }
        setNeedsDisplay()
    }
}
