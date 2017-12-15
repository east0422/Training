//
//  ViewController.swift
//  CustomCell
//
//  Created by dfang on 2017-12-13.
//  Copyright © 2017年 com.east.customcell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MicroBlogFooterViewDelegate {
    
    lazy var tableView: UITableView = UITableView.init()
    lazy var microBlogFrameList: [MicroBlogFrame] = {
        let microBlogList = MicroBlog.microBlogList()
        var _microBlogFrameList = NSMutableArray.init(capacity: microBlogList.count)
       
        for microBlog in microBlogList {
            var microBlogFrame:MicroBlogFrame = MicroBlogFrame.init()
            microBlogFrame.microBlog = microBlog as! MicroBlog
            _microBlogFrameList.add(microBlogFrame)
        }
        
        return _microBlogFrameList as! [MicroBlogFrame]
    }()
    
    lazy var headerView:MicroBlogHeaderView = MicroBlogHeaderView.init(_height: 140)
    lazy var footerView: MicroBlogFooterView = MicroBlogFooterView.init(_height: 34)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        footerView.delegate = self
        
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return microBlogFrameList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let microBlogFrame:MicroBlogFrame = microBlogFrameList[indexPath.row]
        return microBlogFrame.rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MicroBlogCell = MicroBlogCell.microBlogCellWithTableView(tableView: tableView)
        cell.microBlogFrame = microBlogFrameList[indexPath.row]
        return cell
    }
    
    func footerViewDidClickedLoadMoreBtn(footerView: MicroBlogFooterView) {
        print("footerViewDidClickedLoadMoreBtn clicked")
    }
}

