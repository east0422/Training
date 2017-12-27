//
//  Exam3ViewController.swift
//  UIBasicExam
//
//  Created by dfang on 2017-12-28.
//  Copyright © 2017年 dfang. All rights reserved.
//

import Foundation
import UIKit

class Exam3ViewController: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 44, width: screenWidth, height:150))
    let pageController = UIPageControl.init(frame: CGRect.init(x: 0, y: 170, width: screenWidth, height: 20))
    var timer:Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let count = 5
        for i in 1...count {
            let imageView = UIImageView.init(image: UIImage.init(named: String.init(format: "img_%02d", i)))
            imageView.frame = CGRect.init(x: CGFloat((i - 1)) * screenWidth, y: 0, width: screenWidth, height: 150)
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize.init(width: screenWidth * CGFloat(count), height: 150)
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        pageController.currentPage = 0
        pageController.numberOfPages = count
        pageController.currentPageIndicatorTintColor = UIColor.red
        pageController.pageIndicatorTintColor = UIColor.blue
        self.view.addSubview(pageController)
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
    }
    
    // UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageController.currentPage = Int((scrollView.contentOffset.x + scrollView.frame.width/2)/scrollView.frame.width)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
    }
    
    @objc func nextImage() {
        let currentPage = (self.pageController.currentPage + 1) % self.pageController.numberOfPages
        UIView.animate(withDuration: 1) {
            self.scrollView.contentOffset.x = CGFloat(currentPage) * screenWidth
        }
    }
}
