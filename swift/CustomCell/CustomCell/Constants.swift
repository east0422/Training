//
//  Constants.swift
//  CustomCell
//
//  Created by dfang on 2017-12-14.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

import Foundation
import UIKit

public let SCREENWIDTH = UIScreen.main.bounds.size.width
public let SCREENHEIGHT = UIScreen.main.bounds.size.height

public let MICROBLOGNAMEFONTSIZE:CGFloat = 15
public let MICROBLOGTEXTFONTSIZE:CGFloat = 14

public let MICROBLOGCELLREUSEID:String = "microblog"

func RGB(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

