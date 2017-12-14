//
//  ContentScrollView.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/13.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit

class ContentScrollView: UIScrollView {
    
    open var items :Int = 0{
        didSet{
            self.contentSize = CGSize(width: CGFloat(items) * self.bounds.width, height: 0)
            creatChildTableViews(items)
        }
    }
    
    open var type :Int?
    
    fileprivate lazy var contentTableViews :[ContentTableViewController] = {
        let tableviews = [ContentTableViewController]()
        return tableviews
    }()
    
    private func creatChildTableViews(_ items :Int){
        for i in 0..<items {
            let contentTableView = ContentTableViewController(style: .plain)
            
            contentTableView.view.frame = CGRect(x: CGFloat(i) * self.bounds.width, y: 0, width: self.bounds.width, height: self.bounds.height)
            contentTableView.view.backgroundColor = UIColor(red: CGFloat(i) / 6, green: 1, blue: 1, alpha: 1)
            contentTableViews.append(contentTableView)
            addSubview(contentTableView.tableView)
        }
    }
    
    public func scrollToTableView(_ index:Int){
        if index < contentTableViews.count {
            contentTableViews[index].refresh = true
            self.setContentOffset(CGPoint(x: CGFloat(index) * self.bounds.width, y: 0), animated: true)
        }
    }
}






