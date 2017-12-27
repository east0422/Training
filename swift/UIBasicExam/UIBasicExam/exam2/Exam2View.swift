//
//  Exam2View.swift
//  UIBasicExam
//
//  Created by dfang on 2017-12-27.
//  Copyright © 2017年 dfang. All rights reserved.
//

import Foundation
import UIKit

@objc protocol Exam2ViewDelegate: NSObjectProtocol {
    func btnDidClicked(title: String)
}

class Exam2View: UIView {
    var delegate: Exam2ViewDelegate!
    var btnArray: [UIButton] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func createButtons(titles:[String], height:CGFloat) {
        var btnSize = CGSize.zero
        let maxSize = CGSize.init(width: screenWidth, height: height)
        var maxWidth:CGFloat = 0
        var preBtn = UIButton.init(frame: CGRect.zero)
        for title in titles {
            btnSize = self.sizeOfText(text: title, maxSize: maxSize, fontSize: 18)
            maxWidth = CGFloat.maximum(btnSize.width, maxWidth)
            let button = UIButton.init(frame: CGRect.init(x: preBtn.frame.maxX, y: 0.0, width: btnSize.width, height: height))
            button.tag = btnArray.count
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            let range = NSRange.init(location: 0, length: title.count)
            let attributeStrNormal = NSMutableAttributedString.init(string: title)
            attributeStrNormal.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: range)
            button.setAttributedTitle(attributeStrNormal, for: UIControlState.normal)
            let attributeStrSelected = NSMutableAttributedString.init(string: title)
            attributeStrSelected.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: range)
            attributeStrSelected.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range)
            attributeStrSelected.addAttribute(NSAttributedStringKey.underlineColor, value: UIColor.red, range: range)
            button.setAttributedTitle(attributeStrSelected, for: UIControlState.selected)
            button.addTarget(self, action: #selector(btnClicked(button:)), for: UIControlEvents.touchUpInside)
            btnArray.append(button)
            self.addSubview(button)
            
            preBtn = button
        }
        btnArray[0].isSelected = true
        self.resizeBtnsFrame(maxWidth: maxWidth)
    }
    private func sizeOfText(text: String, maxSize: CGSize, fontSize: CGFloat) -> CGSize {
        return NSString.init(string: text).boundingRect(with: maxSize,
                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                 attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize)],
                                                 context: nil).size
    }
    
    private func resizeBtnsFrame(maxWidth: CGFloat) {
        guard btnArray.count > 0 && (btnArray.last?.frame.maxX)! <= screenWidth else { // 最后一个button已经超出屏幕范围忽略不管
            return
        }
        
        if (maxWidth <= screenWidth/CGFloat(btnArray.count)) {
            let btnWidth = screenWidth/CGFloat(btnArray.count)
            var i = 0
            for btn in btnArray {
                btn.frame = CGRect.init(x: CGFloat(i) * btnWidth, y: btn.frame.origin.y, width: btnWidth, height: btn.frame.size.height)
                i = i + 1
            }
        } else {
            let margin = (screenWidth - (btnArray.last?.frame.maxX)!)/2
            for btn in btnArray {
                var origin = btn.frame.origin
                origin.x = origin.x + margin
                btn.frame.origin = origin
            }
        }
    }
    
    @objc private func btnClicked(button:UIButton) {
        for btn in btnArray {
            if (btn.tag == button.tag) {
                if (!btn.isSelected) {
                        btn.isSelected = true
                    if (delegate.responds(to: #selector(Exam2ViewDelegate.btnDidClicked(title:)))) {
                        delegate.btnDidClicked(title: (btn.titleLabel?.text)!)
                    }
                }
            } else {
                btn.isSelected = false
            }
        }
    }
}
