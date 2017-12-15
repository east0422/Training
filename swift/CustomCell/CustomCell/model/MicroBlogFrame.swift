//
//  MicroBlogFrame.swift
//  CustomCell
//
//  Created by dfang on 2017-12-14.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

import Foundation
import UIKit

class MicroBlogFrame: NSObject {
    var textFrame:CGRect
    var iconFrame:CGRect
    var pictureFrame:CGRect
    var nameFrame:CGRect
    var vipFrame:CGRect
    
    var rowHeight: CGFloat
    var microBlog: MicroBlog
    
    override init() {
        textFrame = CGRect.zero
        iconFrame = CGRect.zero
        pictureFrame = CGRect.zero
        nameFrame = CGRect.zero
        vipFrame = CGRect.zero
        rowHeight = 44
        microBlog = MicroBlog.init()
    }
    
    class func sizeWithText(text:String, maxSize:CGSize, fontSize:CGFloat) -> CGSize {
        return (text as NSString).boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }
    
    func setMicroBlog(_microBlog:MicroBlog) {
        microBlog = _microBlog
        
        let margin:CGFloat = 10
        
        let iconW:CGFloat = 30
        let iconH:CGFloat = 30
        let iconX:CGFloat = margin
        let iconY:CGFloat = margin
        iconFrame = CGRect.init(x: iconX, y: iconY, width: iconW, height: iconH)
        
        
        let nameSize:CGSize = MicroBlogFrame.sizeWithText(text: microBlog.name!, maxSize: CGSize.init(width: SCREENWIDTH, height: CGFloat(MAXFLOAT)), fontSize: MICROBLOGNAMEFONTSIZE)
        let nameX:CGFloat = iconFrame.maxX + margin
        let nameY:CGFloat = iconY + (iconH - nameSize.height)/2
        nameFrame = CGRect.init(x: nameX, y: nameY, width: nameSize.width, height: nameSize.height)
        
        let vipW:CGFloat = 14
        let vipH:CGFloat = 14
        let vipX:CGFloat = nameFrame.maxX + margin
        let vipY:CGFloat = nameY
        vipFrame = CGRect.init(x: vipX, y: vipY, width: vipW, height: vipH)
        
        let textSize:CGSize = MicroBlogFrame.sizeWithText(text: microBlog.text!, maxSize: CGSize.init(width: SCREENWIDTH-10, height: CGFloat(MAXFLOAT)), fontSize: MICROBLOGTEXTFONTSIZE)
        let textX:CGFloat = iconX
        let textY:CGFloat = iconFrame.maxY + margin
        textFrame = CGRect.init(origin: CGPoint.init(x: textX, y: textY), size: textSize)
        
        if (nil != microBlog.picture) {
            let pictureW:CGFloat = 100
            let pictureH:CGFloat = 100
            let pictureX:CGFloat = iconX
            let pictureY:CGFloat = textFrame.maxY + margin
            pictureFrame = CGRect.init(x: pictureX, y: pictureY, width: pictureW, height: pictureH)
            rowHeight = pictureFrame.maxY + margin
        }else{
            rowHeight = textFrame.maxY + margin
        }
    }
}
