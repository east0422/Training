//
//  MicroBlogCell.swift
//  CustomCell
//
//  Created by dfang on 2017-12-14.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

import Foundation
import UIKit

class MicroBlogCell: UITableViewCell{
    lazy var nameLabel: UILabel = UILabel.init()
    lazy var descLabel: UILabel = UILabel.init()
    lazy var iconImageView: UIImageView = UIImageView.init()
    lazy var pictureImageView: UIImageView = UIImageView.init()
    lazy var vipImageView: UIImageView = UIImageView.init()
    var _microBlogFrame: MicroBlogFrame = MicroBlogFrame.init()
    
    var microBlogFrame: MicroBlogFrame {
        get {
            return _microBlogFrame
        }
        set (newValue){
            _microBlogFrame = newValue
            _microBlogFrame.setMicroBlog(_microBlog: newValue.microBlog)
            
            // set subviews content
            let microBlog:MicroBlog = _microBlogFrame.microBlog
            nameLabel.text = microBlog.name
            descLabel.text = microBlog.text
            iconImageView.image = UIImage.init(named: microBlog.icon!)
            if (nil != microBlog.picture) {
                pictureImageView.image = UIImage.init(named: microBlog.picture!)
            }
            if microBlog.vip {
                vipImageView.isHidden = false
                nameLabel.textColor = UIColor.red
            } else {
                vipImageView.isHidden = true
                nameLabel.textColor = UIColor.black
            }
            
            // set subviews frame
            nameLabel.frame = _microBlogFrame.nameFrame
            descLabel.frame = _microBlogFrame.textFrame
            iconImageView.frame = _microBlogFrame.iconFrame
            pictureImageView.frame = _microBlogFrame.pictureFrame
            vipImageView.frame = _microBlogFrame.vipFrame
        }
    }
    
    class func microBlogCellWithTableView(tableView: UITableView) -> MicroBlogCell {
        var cell: MicroBlogCell? = tableView.dequeueReusableCell(withIdentifier: MICROBLOGCELLREUSEID) as? MicroBlogCell
        if (nil == cell) {
            cell = MicroBlogCell.init(style: UITableViewCellStyle.default, reuseIdentifier: MICROBLOGCELLREUSEID)
        }
        
        return cell!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addContent() {
        nameLabel.font = UIFont.systemFont(ofSize: MICROBLOGNAMEFONTSIZE)
        self.contentView.addSubview(nameLabel)
        
        descLabel.font = UIFont.systemFont(ofSize: MICROBLOGTEXTFONTSIZE)
        descLabel.numberOfLines = 0
        self.contentView.addSubview(descLabel)
    
        self.contentView.addSubview(iconImageView)
        self.contentView.addSubview(pictureImageView)
        
        vipImageView.image = UIImage.init(named: "vip")
        self.contentView.addSubview(vipImageView)
    }
}
