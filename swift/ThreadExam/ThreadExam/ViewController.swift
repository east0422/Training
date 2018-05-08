//
//  ViewController.swift
//  ThreadExam
//
//  Created by dfang on 2018-5-4.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        Exam1.start()
        
//        let exam2 = Exam2.init()
//        exam2.view.backgroundColor = UIColor.white
//        DispatchQueue.main.async {
//            self.present(exam2, animated: true, completion: nil)
//        }
        
        let exam3 = Exam3.init()
        exam3.view.backgroundColor = UIColor.white
        OperationQueue.main.addOperation {
            self.present(exam3, animated: true, completion: nil)
        }
    }
}

