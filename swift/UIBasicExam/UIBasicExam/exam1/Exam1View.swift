//
//  Exam1View.swift
//  UIBasicExam
//
//  Created by dfang on 2017-12-26.
//  Copyright © 2017年 dfang. All rights reserved.
//

import Foundation
import UIKit

@objc protocol Exam1ViewDelegate: NSObjectProtocol {
    func fontSizeChanged(fontSize: CGFloat);
}

class Exam1View: UIView {
    var delegate:Exam1ViewDelegate!
    
    let sliderMinValue:Float = 8
    let sliderMaxValue:Float = 38
    let gap:Float = 2
    
    
    lazy var btnArray: [UIButton] = {
        var btns:[UIButton] = []
        
        let btnWidht:CGFloat = 70
        let btnHeight:CGFloat = 60
        let btnTop:CGFloat = 20
        let margin:CGFloat = 10
        
        let btnImages:[String] = ["smallest", "small", "big", "biggest"]
        for i in 0...3 {
            let button:UIButton = UIButton.init(frame: CGRect.init(x: (btnWidht + margin) * CGFloat(i), y: btnTop, width: btnWidht, height: btnHeight))
            button.tag = i
            button.setBackgroundImage(UIImage.init(named: btnImages[i]+"_normal"), for: UIControlState.normal)
            button.setBackgroundImage(UIImage.init(named: btnImages[i]+"_highlight"), for: UIControlState.highlighted)
            button.addTarget(self, action:#selector(btnClicked(button:)), for: UIControlEvents.touchUpInside)
            
            btns.append(button)
        }
        return btns
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider.init(frame: CGRect.init(x: 0, y: 80, width: self.frame.size.width, height: 80))
        slider.minimumValue = sliderMinValue
        slider.maximumValue = sliderMaxValue
        slider.value = sliderMinValue
        slider.setThumbImage(UIImage.init(named: "slider"), for: UIControlState.normal)
        slider.setMinimumTrackImage(UIImage.init(named: "slider_highlight"), for: UIControlState.normal)
        slider.setMaximumTrackImage(UIImage.init(named: "slider_normal"), for: UIControlState.normal)
        slider.addTarget(self, action: #selector(sliderChanged(slider:)), for: UIControlEvents.valueChanged)
        return slider
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = UIColor.cyan
        
        for btn in btnArray {
            self.addSubview(btn)
        }
        btnArray[0].isHighlighted = true
        
        self.addSubview(slider)
        
    }

    @objc func sliderChanged(slider:UISlider) {
        for btn in btnArray {
            let btnSliderValue = sliderMinValue + Float(btn.tag) * (sliderMaxValue - sliderMinValue)/Float(btnArray.count-1) // btn 对应的slider值
            btn.isHighlighted = (abs(btnSliderValue - slider.value) <= gap)
        }
        let fontSize = CGFloat(slider.value)
        self.callFontSizeChanged(fontSize: fontSize)
    }
    
    @objc func btnClicked(button:UIButton) {
        for btn in btnArray {
            if (btn.tag == button.tag) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                    btn.isHighlighted = true
                })
            } else {
                btn.isHighlighted = false
            }
        }
        
        let fontSize = sliderMinValue + Float(button.tag) * (sliderMaxValue - sliderMinValue)/Float(btnArray.count - 1)
        slider.value = fontSize
        self.callFontSizeChanged(fontSize: CGFloat(fontSize))
    }
    
    func callFontSizeChanged(fontSize:CGFloat) {
        if (delegate.responds(to: #selector(Exam1ViewDelegate.fontSizeChanged(fontSize:)))) {
            delegate.fontSizeChanged(fontSize: fontSize)
        }
    }
    
}
