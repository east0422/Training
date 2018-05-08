//
//  Exam2.swift
//  ThreadExam
//
//  Created by dfang on 2018-5-7.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class Exam2: UIViewController{
    let marginLeft:CGFloat = 60
    let marginTop:CGFloat = 50
    let width:CGFloat = 80
    let height:CGFloat = 50
    let screenW = UIScreen.main.bounds.width
    let screenH = UIScreen.main.bounds.height
    let imageLeft:CGFloat = 20
    let imageW:CGFloat = 130
    let imageH:CGFloat = 130
    
    lazy var imageView1: UIImageView = UIImageView.init()
    lazy var imageView2: UIImageView = UIImageView.init()
    lazy var mergeImageView:UIImageView = UIImageView.init()
    var image1:UIImage?
    var image2:UIImage?
    
    override func viewDidLoad() {
        addContentView()
    }
    
    func addContentView() {
        let downBtn = UIButton.init(frame: CGRect.init(x: marginLeft, y: marginTop, width: width, height: height))
        downBtn.setTitle("开始下载", for: UIControlState.normal)
        downBtn.setTitleColor(UIColor.green, for: UIControlState.normal)
        downBtn.backgroundColor = UIColor.white
        downBtn.layer.borderWidth = 2
        downBtn.layer.borderColor = UIColor.lightGray.cgColor
        downBtn.layer.cornerRadius = 5
        downBtn.layer.masksToBounds = true
        downBtn.addTarget(self, action: #selector(downClicked), for: UIControlEvents.touchUpInside)
        self.view.addSubview(downBtn)
        
        let mergeBtn = UIButton.init(frame: CGRect.init(x: marginLeft * 2 + width, y: marginTop, width: width, height: height))
        mergeBtn.setTitle("合并图像", for: UIControlState.normal)
        mergeBtn.setTitleColor(UIColor.green, for: UIControlState.normal)
        mergeBtn.backgroundColor = UIColor.white
        mergeBtn.layer.borderWidth = 2
        mergeBtn.layer.borderColor = UIColor.lightGray.cgColor
        mergeBtn.layer.cornerRadius = 5
        mergeBtn.layer.masksToBounds = true
        mergeBtn.addTarget(self, action: #selector(mergeClicked), for: UIControlEvents.touchUpInside)
        self.view.addSubview(mergeBtn)
        
        let imageTop = downBtn.frame.maxY + 10
        imageView1.frame = CGRect.init(x: imageLeft, y: imageTop, width: imageW, height: imageH)
        imageView2.frame = CGRect.init(x: imageLeft * 2 + imageW, y: imageTop, width: imageW, height: imageH)
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        
        let line = UIView.init(frame: CGRect.init(x: 0, y: imageView1.frame.maxY + 10, width: screenW, height: 1))
        line.backgroundColor = UIColor.black
        self.view.addSubview(line)
        
        let mergeLeft = (screenW - imageW * 2)/2
        mergeImageView.frame = CGRect.init(x: mergeLeft, y: line.frame.maxY + 10, width: imageW * 2, height: imageH)
        self.view.addSubview(mergeImageView)
    }
    
    // 开始下载
    @objc func downClicked() {
        // Operation
        let oQueue = OperationQueue.init()
        let operationA = BlockOperation.init {
            print("A:", Thread.current)
            do {
                // 注意fileURLWithPath和string的区别
                let url = URL.init(string: "http://hangge.com/blog/images/logo.png")
                let data = try Data.init(contentsOf: url!, options: Data.ReadingOptions.uncachedRead)
                self.image1 = UIImage.init(data: data)
                print("A finish")
            } catch {
                print("A error:", error)
            }
            
//            let url = URL.init(string: "http://hangge.com/blog/images/logo.png")
            // task 会新开一个线程
//            let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//                print("A task:", Thread.current)
//                if (error == nil) {
//                    OperationQueue.main.addOperation({
//                        self.image1 = UIImage.init(data: data!)
//                    })
//                } else {
//                    print("A error:", error.debugDescription)
//                }
//            })
//            task.resume()
        }
        let operationB = BlockOperation.init {
//            let path = Bundle.main.path(forResource: "female.png", ofType: nil)
//            self.image2 = UIImage.init(contentsOfFile: path!)
            
            do {
                print("B:", Thread.current)
                let url = Bundle.main.url(forResource: "female", withExtension: "png")
                let data = try Data.init(contentsOf: url!)
                
                self.image2 = UIImage.init(data: data)
                print("B finish")
            } catch {
                print("error B:",error)
            }
        }
        
        let mainQueue = OperationQueue.main
        let operationC = BlockOperation.init {
            print("C:", Thread.current)
            print("down finish")
            self.imageView1.image = self.image1
            self.imageView1.layer.borderColor = UIColor.black.cgColor
            self.imageView1.layer.borderWidth = 1
            self.imageView2.image = self.image2
            self.imageView2.layer.borderColor = UIColor.black.cgColor
            self.imageView2.layer.borderWidth = 1
        }
        
        // 添加依赖
        operationC.addDependency(operationA)
        operationC.addDependency(operationB)
        // 将下载操作添加到操作队列中
        oQueue.addOperation(operationA)
        oQueue.addOperation(operationB)
        // 将更新UI添加到主队列中
        mainQueue.addOperation(operationC)
    }
    
    // 合并图片
    @objc func mergeClicked() {
        // 开始绘制图片的大小
        UIGraphicsBeginImageContext(CGSize.init(width: imageW * 1.5, height: imageH))
        // 设置一个变量用来获取UIImage的Y值
        self.image1?.draw(in: CGRect.init(x: 0, y: 20, width: imageW, height: imageH), blendMode: CGBlendMode.normal, alpha: 0.3)
        self.image2?.draw(in: CGRect.init(x: imageW/2, y: 20, width: imageW, height: imageH), blendMode: CGBlendMode.normal, alpha: 1)
        // 获取已经绘制好的图片
        let drawImage = UIGraphicsGetImageFromCurrentImageContext()
        // 结束绘制图片
        UIGraphicsEndImageContext()
        
        self.mergeImageView.image = drawImage
        self.mergeImageView.layer.borderColor = UIColor.black.cgColor
        self.mergeImageView.layer.borderWidth = 1
        print("merge finished")
        
        saveImage(curImage: drawImage!, imageName: "test1.png")
    }
    
    // 保存图片至沙盒
    func saveImage(curImage: UIImage, imageName: String) {
        do {
            let imageData = UIImagePNGRepresentation(curImage)
            let fullPath = NSHomeDirectory().appending("/Documents/").appending(imageName)
            // 注意fileURLWithPath和string的区别
            let saveURL = URL.init(fileURLWithPath: fullPath)
            try imageData?.write(to: saveURL, options: NSData.WritingOptions.atomicWrite)
            print("saveImage success fullPath=\(fullPath)")
        } catch {
            print("saveImage error:", error)
        }
    }
}
