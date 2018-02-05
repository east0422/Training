//
//  WaterImageView.swift
//  Quartz2DDemo
//
//  Created by dfang on 2018-2-4.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class WaterImageView: UIImage {
    
    class func waterImageWith(bgImageName:String, waterImageName:String, scale:Float) -> UIImage {
        let bgImage = UIImage.init(named: bgImageName)
        let waterImage = UIImage.init(named: waterImageName)
        let bgImageSize = (bgImage?.size)!
        UIGraphicsBeginImageContextWithOptions(bgImageSize, false, CGFloat(scale))
        bgImage?.draw(in: CGRect.init(origin: CGPoint.zero, size: bgImageSize))
        
        // 水印图片缩放比例
        let waterScale:CGFloat = 0.4
        let waterImageSize = (waterImage?.size)!
        let waterW = waterImageSize.width * waterScale
        let waterH = waterImageSize.height * waterScale
        let waterX = bgImageSize.width - waterW
        let waterY = bgImageSize.height - waterH
        waterImage?.draw(in: CGRect.init(x: waterX, y: waterY, width: waterW, height: waterH))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
