//
//  MicroBlogHeaderView.swift
//  CustomCell
//
//  Created by dfang on 2017-12-14.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

import Foundation
import UIKit

class MicroBlogHeaderView: UIView, UIScrollViewDelegate {
    var height: CGFloat = 0.0
    lazy var scrollView: UIScrollView = {
        let _scrollView: UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: height))
        for i in 0...4 {
            let imageView:UIImageView = UIImageView.init(frame: CGRect.init(x: CGFloat(i) * SCREENWIDTH, y: 0, width: SCREENWIDTH, height: height))
            imageView.image = UIImage.init(named: String.init(format: "ad_%02d", i))
            _scrollView.addSubview(imageView)
        }
        _scrollView.contentSize = CGSize.init(width: CGFloat(5) * SCREENWIDTH, height: height)
        
        return _scrollView
    }()
    
    lazy var pageController: UIPageControl = {
        let _pageController:UIPageControl = UIPageControl.init(frame: CGRect.init(x: 0, y: height-20, width: SCREENWIDTH, height: 20))
        _pageController.numberOfPages = 5
        _pageController.currentPage = 0
        _pageController.pageIndicatorTintColor = UIColor.white
        _pageController.currentPageIndicatorTintColor = UIColor.yellow
        return _pageController
    }()
    
    init(_height: CGFloat) {
        height = _height
        super.init(frame: CGRect.init(x: 0, y: 0, width: SCREENWIDTH, height: height))
        scrollView.delegate = self
        self.addSubview(scrollView)
        self.addSubview(pageController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let curPage: NSInteger = NSInteger((scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width)
        pageController.currentPage = curPage
    }
}
