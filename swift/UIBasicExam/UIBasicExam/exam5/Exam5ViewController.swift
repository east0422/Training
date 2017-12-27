//
//  Exam5ViewController.swift
//  UIBasicExam
//
//  Created by dfang on 2017-12-28.
//  Copyright © 2017年 dfang. All rights reserved.
//

import Foundation
import UIKit

class Exam5ViewController: UIViewController, UIScrollViewDelegate {
    let scrollView = UIScrollView.init()
    let sunImageView = UIImageView.init()
    let moveImageView = UIImageView.init()
    
    override func viewDidLoad() {
        scrollView.frame = self.view.frame
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        let bgImageView = UIImageView.init(image: UIImage.init(named: "520_userguid_bg"))
        scrollView.addSubview(bgImageView)
        
        let cloudImageView = UIImageView.init(image: UIImage.init(named: "520_userguid_cloud"))
        scrollView.addSubview(cloudImageView)
        
        let footerBgImageView = UIImageView.init(image: UIImage.init(named: "520_userguid_fg"))
        var origin = footerBgImageView.frame.origin
        origin.y = screenHeight - footerBgImageView.frame.size.height
        footerBgImageView.frame.origin = origin
        scrollView.addSubview(footerBgImageView)
        
        let wordsImageView = UIImageView.init(image: UIImage.init(named: "520_userguid_words_5"))
        wordsImageView.frame = CGRect.init(x: 0, y: 70, width: screenWidth, height: 100)
        scrollView.addSubview(wordsImageView)
        
        let sceneImageView = UIImageView.init(image: UIImage.init(named: "520_userguid_cg"))
        scrollView.addSubview(sceneImageView)
        
        sunImageView.frame = CGRect.init(x: screenWidth - 60, y: 10, width: 60, height: 60)
        sunImageView.image = UIImage.init(named: "520_userguid_sun")
        scrollView.addSubview(sunImageView)
        
        moveImageView.frame = CGRect.init(x: (screenWidth - 150)/2, y: screenHeight - 200, width: 150, height: 200)
        moveImageView.image = UIImage.init(named: "520_userguid_person_weigou")
        moveImageView.animationImages = [UIImage.init(named: "520_userguid_person_taitou_1")!,
                                         UIImage.init(named: "520_userguid_person_ditou_1")!,
                                         UIImage.init(named: "520_userguid_person_taitou_2")!,
                                         UIImage.init(named: "520_userguid_person_ditou_2")!]
        moveImageView.animationDuration = 0.5
        scrollView.addSubview(moveImageView)
        
        scrollView.contentSize = CGSize.init(width: bgImageView.frame.maxX, height: screenHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let moveX = scrollView.contentOffset.x
        var sunOrigin = sunImageView.frame.origin
        sunOrigin.x = moveX + (scrollView.frame.width - 60)
        sunImageView.frame.origin = sunOrigin
        
        var moveOrigin = moveImageView.frame.origin
        moveOrigin.x = moveX + (scrollView.frame.width - 150)/2
        moveImageView.frame.origin = moveOrigin
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        moveImageView.startAnimating()
        
        let rotationAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = NSNumber.init(value: 0)
        rotationAnimation.toValue = NSNumber.init(value: Double.pi * 2.0)
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = 100
        sunImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        moveImageView.stopAnimating()
        
        sunImageView.layer.removeAllAnimations()
    }
}
