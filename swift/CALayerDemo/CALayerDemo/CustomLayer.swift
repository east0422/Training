//
//  CustomLayer.swift
//  CALayerDemo
//
//  Created by dfang on 2018-3-5.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class CustomLayer: CALayer {
    
    override func draw(in ctx: CGContext) {
        ctx.fillEllipse(in: CGRect.init(x: 0, y: 0, width: 100, height: 100))
    }
}
