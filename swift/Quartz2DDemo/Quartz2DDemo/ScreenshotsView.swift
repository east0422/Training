//
//  ScreenshotsView.swift
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-5.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ScreenshotsView: UIView {
    
    override func draw(_ rect: CGRect) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshots = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(screenshots!, self, nil, nil)
    }
}
