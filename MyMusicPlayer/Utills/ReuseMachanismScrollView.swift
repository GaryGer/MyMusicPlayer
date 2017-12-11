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
   
    fileprivate var displayChildCells :[UIScrollViewCell]?
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
        
//        print("layoutSubviews")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        numberOfItems = numberOfCell() ?? 0
        print("willMovetoSuperview")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        var displayNum = 0
        for itemCount in 0..<numberOfItems {
//            if let displayItemSize = itemSize(itemCount){
////                displayItemsSizeList?.append(displayItemSize)
//
//                //如果 displayItemsSizeList 中的显示超出屏幕 break
//
//            }
           displayNum = numberOfDisplay(direction, itemNum: itemCount)
        }
        
        //先确定可以显示 i 个cell，然后创建 i+1 个cell
//        let displayNum = numberOfDisplay(direction) + 1
//        print(displayNum)
//        for index in 0..<displayNum{
//            let displayCell = creatCellForRowAtIndex(index)
//
//            if let optionDisPCell = displayCell {
//                displayChildCells?.append(optionDisPCell)
//            }
//        }
    }
    
    private func numberOfDisplay(_ direction :SubViewDirection,itemNum:Int) -> Int{
        switch direction {
        case .horizontal:
            displayItemCount = Int(Swidth / itemSize.width)
        case .vertical:
            displayItemCount = Int(SHeight / itemSize.height)
        }
        return displayItemCount
    }
    
    
    
}
extension ReuseMachanismScrollView{
    
    fileprivate func numberOfCell() -> Int?{
        return dateSource?.numberOfItems(inScrollView: self) ?? 0
    }
    
    fileprivate func creatCellForRowAtIndex(_ index:Int) -> UIScrollViewCell?{
        return dateSource?.cellForRow(scrollView: self, index: index)
    }
    
    fileprivate func itemSize(_ index:Int) -> CGSize?{
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
    
    convenience init(frame: CGRect,reuseIdentifier:String){
        self.init(frame: frame)
        //set dequeueCells
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
    
    static let `default` = CellDeueuePool()
    private init(){}
    
    func setDequeueCells(dequeueCells:[[String:UIScrollViewCell]]?){
        self.dequeueCells = dequeueCells
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











