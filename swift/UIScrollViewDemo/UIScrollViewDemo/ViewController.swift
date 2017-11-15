//
//  ViewController.swift
//  UIScrollViewDemo
//
//  Created by dfang on 2017-11-15.
//  Copyright © 2017年 com.east. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var zoomScrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let count = 5
        let size = scrollView.frame.size
        for i in 0...count-1 {
            let imageView: UIImageView = UIImageView.init(frame: CGRect.init(x: size.width * CGFloat(i), y: 0, width: size.width, height: size.height))
            let imageName: String = String.init(format: "img_%02d", (i + 1))
            imageView.image = UIImage.init(named: imageName)
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize.init(width: size.width * CGFloat(count), height: 0)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        pageControl.numberOfPages = count
        
        zoomScrollView.isScrollEnabled = false
        zoomScrollView.delegate = self
        zoomScrollView.maximumZoomScale = 2
        zoomScrollView.minimumZoomScale = 0.5
        
        addImageTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let nextPage = (self.scrollView.contentOffset.x + self.scrollView.frame.size.width / 2 ) / self.scrollView.frame.size.width
        pageControl.currentPage = Int(nextPage)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addImageTimer()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        timer.invalidate()
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        addImageTimer()
    }
    
    func addImageTimer() {
        timer = Timer.init(timeInterval: 2, repeats: true, block: { (finished) in
            let nextPage = (self.pageControl.currentPage + 1) % self.pageControl.numberOfPages
            UIView.animate(withDuration: 1, animations: {
                self.scrollView.contentOffset = CGPoint.init(x: CGFloat(nextPage) * self.scrollView.frame.size.width, y: 0)
            })
        })
        let runloop: RunLoop = RunLoop.current
        runloop.add(timer, forMode: RunLoopMode.commonModes)
        timer.fire()
    }
}

