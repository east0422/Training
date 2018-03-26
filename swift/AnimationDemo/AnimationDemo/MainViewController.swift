//
//  MainViewController.swift
//  AnimationDemo
//
//  Created by dfang on 2018-3-19.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        tabBar.tintColor = UIColor.orange
        creatSubViewControllers()
    }
    
    func creatSubViewControllers() {
        // 先创建好所有的vc再一次添加到viewcontrollers中
        let basicVC = BasicAnimationViewController.init()
        addChildViewController(childController: basicVC, title: "基本动画", imageName: "TabBar1")
        let kfVC = KeyFrameViewController.init()
        addChildViewController(childController: kfVC, title: "帧动画", imageName: "TabBar2")
        let transitionVC = TransitionViewController.init()
        addChildViewController(childController: transitionVC, title: "转场动画", imageName: "TabBar3")
        let agVC = AnimationGroupViewController.init()
        addChildViewController(childController: agVC, title: "组动画", imageName: "TabBar4")
        let summaryVC = SummaryViewController.init()
        addChildViewController(childController: summaryVC, title: "动画总结", imageName: "TabBar5")
        
        // If you change the value of this property at runtime,
        // the tab bar controller removes all of the old view controllers before installing the new ones.
        // The tab bar items for the new view controllers are displayed immediately and are not animated into position.
        viewControllers = [UINavigationController.init(rootViewController: basicVC),
                           UINavigationController.init(rootViewController: kfVC),
                           UINavigationController.init(rootViewController: transitionVC),
                           UINavigationController.init(rootViewController: agVC),
                           UINavigationController.init(rootViewController: summaryVC)]
        
        // 更改more对应tableview样式，不推荐，也许某天apple将topViewController?.view更改为非tableview
        let topView = moreNavigationController.topViewController?.view
        if (topView?.isKind(of: UITableView.self))! {
            let tableView:UITableView = topView as! UITableView

            // 设置datasource设置代理，在代理方法中处理
//            tableView.dataSource = self
//            tableView.delegate = self
            
            tableView.rowHeight = 100
            tableView.tableFooterView = UIView.init(frame: CGRect.zero)
        }
        
        // 2 创建一个VC就添加到viewcontrollers中
//        addChildViewController(childController: BasicAnimationViewController(), title:"基本动画", imageName:"TabBar1")
//        addChildViewController(childController: KeyFrameViewController(), title:"帧动画", imageName: "TabBar2")
//        addChildViewController(childController: TransitionViewController(), title: "转场动画", imageName: "TabBar3")
//        addChildViewController(childController: AnimationGroupViewController(), title: "组动画", imageName: "TabBar4")
//        addChildViewController(childController: SummaryViewController(), title: "动画总结", imageName: "TabBar5")
    }
    
    // ios7之后设置tabBarItem的image需要渲染否则图片不会显示，默认图片会向上偏移，需设置tabBarItem的imageInsets
    func addChildViewController(childController: UIViewController,title:String,imageName:String) {
        childController.tabBarItem.title = title
        childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        childController.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "Sel")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        // 2.1
//        if (viewControllers == nil) {
//            viewControllers = [UINavigationController.init(rootViewController: childController)]
//        } else {
//            viewControllers!.append(UINavigationController.init(rootViewController: childController))
//        }
        
        // 2.2 超过5个后，后面的不显示
//        addChildViewController(UINavigationController.init(rootViewController: childController))
    }
}
