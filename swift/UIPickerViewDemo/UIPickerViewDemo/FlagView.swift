//
//  FlagView.swift
//  UIPickerViewDemo
//
//  Created by dfang on 2018-1-5.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class FlagView: UIView {

    let nameLabel = UILabel.init()
    let iconImageView = UIImageView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameLabel.frame = CGRect.init(x: 10, y: 0, width: 80, height: frame.height)
        self.addSubview(nameLabel)
        iconImageView.frame = CGRect.init(x: 90, y: 0, width: 100, height: frame.height)
        self.addSubview(iconImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
