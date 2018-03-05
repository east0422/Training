//
//  ImageCrop.swift
//  CALayerDemo
//
//  Created by dfang on 2018-3-5.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

extension UIImage {
    class func crop(imageName: String, cornerRadius: Float, borderWidth: Float, borderColor: UIColor) -> UIImage {
        let souceImage = UIImage.init(named: imageName)
        
        let imageSize = (souceImage?.size)!
        UIGraphicsBeginImageContextWithOptions(imageSize, true, 1)
        let layer = CALayer.init()
        layer.frame = CGRect.init(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        layer.cornerRadius = CGFloat(cornerRadius)
        
        // 裁剪
        layer.masksToBounds = true
        layer.borderWidth = CGFloat(borderWidth)
        layer.borderColor = borderColor.cgColor
        layer.contents = souceImage?.cgImage
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let cropImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return cropImage!
    }
}
