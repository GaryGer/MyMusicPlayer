//
//  ContentScrollView.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/13.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit

class ContentScrollView: UIScrollView {
    fileprivate lazy var contentTableViews :[ContentTableViewController] = {
        let tableviews = [ContentTableViewController]()
        return tableviews
    }()
    
    fileprivate var isAllowScroll :Bool = false
    fileprivate var startOffSet_X :CGFloat = 0.0
    fileprivate var scrollingOffSet_X :CGFloat = 0.0
    fileprivate var endOffSet_X :CGFloat = 0.0
    
    open var items :Int = 0{
        didSet{
            self.contentSize = CGSize(width: CGFloat(items) * self.bounds.width, height: 0)
            creatChildTableViews(items)
        }
    }
    
    open var type :Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ContentScrollView {
    
    fileprivate func creatChildTableViews(_ items :Int){
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

extension ContentScrollView :UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffSet_X = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollingOffSet_X = scrollView.contentOffset.x
        
//        if (scrollingOffSet_X / Int(Swidth * 0.5) - scrollingOffSet_X / Int(Swidth * 0.5)) > 0 {
//            
//        }
        
//        if startOffSet_X < scrollingOffSet_X {
//            print("向左滑")
//        }else{
//            print("向右滑🌺")
//        }
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        endOffSet_X = scrollView.contentOffset.x
    }
}




















