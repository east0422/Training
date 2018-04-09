//
//  Exam1ViewController.swift
//  UIAdvancedExam
//
//  Created by dfang on 2018-4-8.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class Exam1ViewController: UIViewController {
    @IBOutlet weak var redView: UIView!
    
    lazy var viewW: CGFloat = {
        return view.frame.size.width
    }()
    
    lazy var viewH: CGFloat = {
        return view.frame.size.height
    }()
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func redViewMoved(_ gesture: UIPanGestureRecognizer) {
        // 横纵坐标上拖动的像素
        let point = gesture.translation(in: gesture.view)
        redView.transform = redView.transform.translatedBy(x: point.x, y: point.y)
        gesture.setTranslation(CGPoint.zero, in: redView)
    
        if (gesture.state == UIGestureRecognizerState.ended) {
            var tabHeight:CGFloat = 0
            if (tabBarController != nil) { // 底部tab
                tabHeight = tabBarController!.tabBar.frame.size.height
            }
            var headerHeight:CGFloat = 0
            if (navigationController != nil) { // 导航栏高度
                headerHeight = navigationController!.navigationBar.frame.size.height
            }
            if (!prefersStatusBarHidden) { // 状态栏是否显示
                headerHeight += 20
            }
            var redViewOrigin = redView.frame.origin
            if (redViewOrigin.y < 60 + headerHeight) {
                redViewOrigin.y = headerHeight
            } else if (viewH - tabHeight - 60 < redView.frame.maxY) {
                redViewOrigin.y = viewH - tabHeight - redView.frame.height
            } else {
                if (redViewOrigin.x <= viewW * 0.5) {
                    redViewOrigin.x = 0
                } else {
                    redViewOrigin.x = viewW - redView.frame.width
                }
            }
            
            if (redViewOrigin.x < 0) {
                redViewOrigin.x = 0
            } else if (redView.frame.maxX > viewW) {
                redViewOrigin.x = viewW - redView.frame.width
            }
            
            redView.frame.origin = redViewOrigin
        }
    }
}
