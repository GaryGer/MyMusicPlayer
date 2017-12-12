//
//  ReuseMachanismScrollView.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/11.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit
protocol UIScrollViewDateSource {
    func numberOfItems(inScrollView:ReuseMachanismScrollView) -> Int?
    func cellForRow(scrollView:ReuseMachanismScrollView,index:Int) -> UIScrollViewCell?
    func itemSizeForRow(scrollView:ReuseMachanismScrollView,index:Int) -> CGSize?
}

class ReuseMachanismScrollView: UIScrollView {
    
    enum SubViewDirection {
        case horizontal         //横向
        case vertical           //垂直
    }

    var dateSource:UIScrollViewDateSource?
    var direction :SubViewDirection = .horizontal   // default horizontal
    var itemSpace :CGFloat = 0.0
    fileprivate var itemSize :CGSize = CGSize(width: 50, height: 50)    //default Size
   
    fileprivate var childCells :[UIScrollViewCell]?
    fileprivate var displayItemsSizeList :[CGSize]?
    fileprivate var scrollViewCell :UIScrollViewCell?
    fileprivate var numberOfItems :Int = 0
    fileprivate var displayItemCount :Int = 0
    fileprivate var reuseIdentifier:String?
    
    fileprivate var reuseCellPool :CellDeueuePool = {
        let pool = CellDeueuePool.default
        return pool
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        numberOfItems = numberOfCell() ?? 0
        print("willMovetoSuperview")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        //创建两个view
        for index in 0..<2 {
            //从代理对象获取itemSize
            itemSize = getItemSize(index) ?? CGSize(width: 50, height: 50)
            reuseCellPool.setItemSize(sizeDict: [index:itemSize])
            if let optionCell = creatCellForRowAtIndex(index){
                childCells?.append(optionCell)
                optionCell.frame = CGRect(x: 0 + CGFloat(index) * Swidth, y: 0, width: bounds.width, height: bounds.height)
                optionCell.backgroundColor = UIColor(red: CGFloat(index) / 6.0, green: 0.0, blue: 0.0, alpha: 1.0)
                addSubview(optionCell)
            }
        }
    }
    
    public func scrollViewDidSelect(_ atIndex:Int){
        
    }
}


extension ReuseMachanismScrollView{
    
    fileprivate func numberOfCell() -> Int?{
        return dateSource?.numberOfItems(inScrollView: self) ?? 0
    }
    
    fileprivate func creatCellForRowAtIndex(_ index:Int) -> UIScrollViewCell?{
        scrollViewCell = dateSource?.cellForRow(scrollView: self, index: index)
        return scrollViewCell
    }
    
    fileprivate func getItemSize(_ index:Int) -> CGSize?{
        return dateSource?.itemSizeForRow(scrollView: self, index: index)
    }
}

extension ReuseMachanismScrollView{
    
    public func register(class:Swift.AnyClass?,forCellReuseIdentifier:String){
        
    }
    
    public func dequeueReusableCellIdentifier(_ reuseIdentifier:String) -> UIScrollViewCell? {
        
        return reuseCellPool.getCellFromDequeue(identifier:reuseIdentifier)
    }
}

extension ReuseMachanismScrollView :UIScrollViewDateSource{

    func itemSizeForRow(scrollView: ReuseMachanismScrollView, index: Int) -> CGSize? {
        fatalError("must compelete func numberOfItems")
    }
    
    func numberOfItems(inScrollView: ReuseMachanismScrollView) -> Int? {
        fatalError("must compelete func numberOfItems")
    }
    
    func cellForRow(scrollView: ReuseMachanismScrollView, index: Int) -> UIScrollViewCell? {
        fatalError("must compelete func cellForRowAtIndex")
    }
}

class UIScrollViewCell: UIView {
    
    convenience init(reuseIdentifier:String){
        
        //需要知道itemSize
        self.init(frame: CGRect.zero)
        CellDeueuePool.default.setDequeueCells(cellDict: [reuseIdentifier:self])
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CellDeueuePool {
    
    var dequeueCells:[[String:UIScrollViewCell]]?
    var itemSizes :[[Int:CGSize]]?
    
    static let `default` = CellDeueuePool()
    private init(){}
    func setItemSize(sizeDict:[Int:CGSize]?) {
        if let optionSizeDict = sizeDict {
            if let optionItemSizes = itemSizes {
                for item in optionItemSizes {
                    if item != optionSizeDict {
                        self.itemSizes?.append(optionSizeDict)
                    }
                }
            }
        }
    }
    func setDequeueCells(cellDict:[String:UIScrollViewCell]?){
        if let optionCellDict = cellDict {
            if let optionDueueCells = dequeueCells {
                for item in optionDueueCells {
                    if item != optionCellDict {
                        self.dequeueCells?.append(optionCellDict)
                    }
                }
            }
        }
    }
    
    func getCellFromDequeue(identifier:String) -> UIScrollViewCell?{
        if let optionDeueueCells = dequeueCells {
            for cellDict in optionDeueueCells {
                if cellDict[identifier] != nil {
                    return cellDict[identifier]
                }else{
                    continue
                }
            }
        }
        return nil
    }
}











