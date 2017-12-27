//
//  ViewController.swift
//  UIBasicExam
//
//  Created by dfang on 2017-12-26.
//  Copyright © 2017年 dfang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Exam1ViewDelegate, Exam2ViewDelegate {
    
    // exam1
    lazy var titleLabel: UILabel = {
        var title:UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 60, width: screenWidth, height: 60))
        title.text = "测试文字"
        title.textAlignment = NSTextAlignment.center
        title.font = UIFont.systemFont(ofSize: 8)
        title.textColor = UIColor.black
        return title
    }()
    
    // exam2
    let btnTitles = ["新闻", "最新动态", "黑马"]
    let exam2:Exam2View = Exam2View.init(frame: CGRect.init(x: 0, y: 60, width: screenWidth, height: screenHeight))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // exam1 Exam1View
//        let exam1:Exam1View = Exam1View.init(frame: CGRect.init(x: 0, y: titleLabel.frame.maxY, width: screenWidth, height: 200))
//        exam1.delegate = self
//        self.view.addSubview(titleLabel)
//        self.view.addSubview(exam1)
        
        // exam2 Exam2View
//        exam2.delegate = self
//        exam2.createButtons(titles: btnTitles, height: 60)
//        self.view.addSubview(exam2)
        
        // exam3 Exam3ViewController
//        let exam3ViewCotroller = Exam3ViewController.init()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//            self.present(exam3ViewCotroller, animated: true, completion: nil)
//        }
        
        // exam4 Exam4ViewController
//        let exam4ViewController = Exam4ViewController.init()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
//            self.present(exam4ViewController, animated: true, completion: nil)
//        }
        
        // exam5 Exam5ViewController
        let exam5ViewController = Exam5ViewController.init()
        DispatchQueue.main.async {
            self.present(exam5ViewController, animated: true, completion: nil)
        }
    }

    // Exam1ViewDelegate
    func fontSizeChanged(fontSize: CGFloat) {
        titleLabel.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    // Exam2ViewDelegate
    func btnDidClicked(title: String) {
        let backColors = [UIColor.white, UIColor.cyan, UIColor.lightGray]
        exam2.backgroundColor = backColors[btnTitles.index(of: title)!]
        print("clicked button with title " + title + " and index of btnTitles is ")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

