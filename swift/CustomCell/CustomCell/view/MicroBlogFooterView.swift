//
//  MicroBlogFooterView.swift
//  CustomCell
//
//  Created by dfang on 2017-12-14.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

import Foundation
import UIKit

@objc protocol MicroBlogFooterViewDelegate: NSObjectProtocol {
    @objc optional func footerViewDidClickedLoadMoreBtn(footerView: MicroBlogFooterView)
}

class MicroBlogFooterView: UIView {
    var height:CGFloat = 0.0
    var delegate: MicroBlogFooterViewDelegate!
    
    lazy var loadMoreBtn: UIButton = {
        let _loadMoreBtn:UIButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: height))
        _loadMoreBtn.backgroundColor = UIColor.orange
        _loadMoreBtn.isEnabled = true
        _loadMoreBtn.setTitle("加载更多...", for: UIControlState.normal)
        _loadMoreBtn.layer.cornerRadius = 5
        _loadMoreBtn.layer.masksToBounds = true
        _loadMoreBtn.addTarget(self, action: #selector(loadMoreClick), for: UIControlEvents.touchUpInside)
        
        return _loadMoreBtn
    }()
    
    lazy var loadingView:UIView = {
        let _loadingView:UIView = UIView.init(frame:CGRect.init(x: (SCREENWIDTH - 200)/2, y: 11, width: 200, height: height - 11))
        let indicatorView:UIActivityIndicatorView = UIActivityIndicatorView.init(frame: CGRect.init(x: 20, y: 2, width: 20, height: 20))
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        indicatorView.startAnimating()
        _loadingView.addSubview(indicatorView)
        
        let loadingLabel:UILabel = UILabel.init(frame: CGRect.init(x: 50, y: 0, width: 150, height: height-11))
        loadingLabel.text = "拼命加载中..."
        loadingLabel.textColor = UIColor.black
        _loadingView.addSubview(loadingLabel)
        
        _loadingView.isHidden = true
        return _loadingView
    }()
    
    init(_height: CGFloat) {
        height = _height
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: height))
        self.addSubview(loadMoreBtn)
        self.addSubview(loadingView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func loadMoreClick() {
        loadMoreBtn.isHidden = true
        loadingView.isHidden = false
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadMoreBtn.isHidden = false
            self.loadingView.isHidden = true
            
            if (self.delegate.responds(to: #selector(MicroBlogFooterViewDelegate.footerViewDidClickedLoadMoreBtn(footerView:)))) {
                self.delegate.footerViewDidClickedLoadMoreBtn!(footerView: self)
            }
        }
    }
}
