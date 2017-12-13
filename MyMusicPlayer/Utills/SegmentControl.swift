//
//  SegmentControl.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/6.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit
//import SnapKit

let Swidth =  UIScreen.main.bounds.width
let SHeight =  UIScreen.main.bounds.height

protocol SegmentDelegate {
    func segmentItemDidClick(tag:Int)
}

class SegmentControl: UIControl {
    
    fileprivate var labelWidth :CGFloat = 100.0
    fileprivate var labelHeight :CGFloat = 40
    fileprivate var labelY :CGFloat = 0.0
    var delegate :SegmentDelegate?
    
    fileprivate var transformLabel :CustomAnimationLabel?
    fileprivate lazy var transformLabels :[CustomAnimationLabel]? = {
        let labels = [CustomAnimationLabel]()
        return labels
    }()
    
    fileprivate var items :[String] = []
    fileprivate lazy var selectionIndicator :UIView = {
        let indicatorView = UIView(frame: CGRect(x: 15, y: self.labelHeight - 2, width: self.labelWidth - 30, height: 2))
        indicatorView.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1)
        return indicatorView
    }()
    
    open var selectionIndicatorColor :UIColor? {
        didSet{
            selectionIndicator.backgroundColor = selectionIndicatorColor
        }
    }
    
    open var labelSelectColor = UIColor.red
    open var labelNormalColor = UIColor.black
    open var defaultSlectIndex = 0  //  小于label总数，否则默认选择0
    
    fileprivate lazy var topScrollView :UIScrollView = {
        let topScrView = UIScrollView()
        topScrView.backgroundColor = UIColor.white
        topScrView.showsHorizontalScrollIndicator = false
        return topScrView
    }()
    
    init(items:[String]){
        self.items = items
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.items = []
        super.init(coder: aDecoder)
    }
    
}

extension SegmentControl {
    override func willMove(toSuperview newSuperview: UIView?) {
        addSubview(topScrollView)
        addLabels()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topScrollView.frame = self.bounds
    }
    
    fileprivate func addLabels() {
        // W:70 H:40
        //如果标签个数 i * W < Swidth，则平均铺满显示
        if CGFloat(self.items.count) * labelWidth < self.bounds.width {
            labelWidth = self.bounds.width / CGFloat(self.items.count)
            creatLabels(labelWidth)
        }else{
            labelWidth = 100.0
            creatLabels(labelWidth)
        }
    }
    
    fileprivate func creatLabels(_ labelWidth:CGFloat){
        transformLabels?.removeAll()
        for i in 0..<self.items.count {
            let customLabel = CustomAnimationLabel(frame: CGRect(x: CGFloat(i) * labelWidth, y: 0, width: labelWidth, height: labelHeight))
            customLabel.text = items[i]
            customLabel.tag = i
            customLabel.normalColor = labelNormalColor
            customLabel.selectColor = labelSelectColor
            customLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customLabelClick(recognizer:))))
            transformLabels?.append(customLabel)
            topScrollView.addSubview(customLabel)
            if i == defaultSlectIndex && defaultSlectIndex < self.items.count{
                defaultSelectLabel(transformLabels?[i])
            }else if defaultSlectIndex >= self.items.count {
                defaultSelectLabel(transformLabels?[0])
            }
        }
        topScrollView.contentSize = CGSize(width: CGFloat(self.items.count) * labelWidth, height: 0)
        topScrollView.addSubview(selectionIndicator)
    }
    
    @objc fileprivate func customLabelClick(recognizer:UIGestureRecognizer){
        let clickLabel = recognizer.view as? CustomAnimationLabel
        if transformLabel?.tag == clickLabel?.tag { return }
        transformLabelState(clickLabel)
    }
    //默认选择
    fileprivate func defaultSelectLabel(_ selectLabel:CustomAnimationLabel?){
        if transformLabel?.tag == selectLabel?.tag { return }
        transformLabelState(selectLabel)
    }
    
    fileprivate func transformLabelState(_ selectLabel:CustomAnimationLabel?){
        transformLabel?.isSelected = false
        selectLabel?.isSelected = true
        transformLabel = selectLabel
        setContentOffSet(selectLabel)
    }
    
    fileprivate func setContentOffSet(_ clickLabel:CustomAnimationLabel?){
        
        let offSetX = clickLabel?.center.x ?? 0.0
        let ABS_OffSetX = offSetX - Swidth * 0.5
        let maxRightOffSetX = topScrollView.contentSize.width - Swidth
        
        if offSetX > Swidth * 0.5 {
            if maxRightOffSetX >= ABS_OffSetX {
                scrollViewScrollToPoint(CGPoint(x: ABS_OffSetX, y: 0))
            }else{
                scrollViewScrollToPoint(CGPoint(x: maxRightOffSetX, y: 0))
            }
        }else{
            scrollViewNeedNotScroll()
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.selectionIndicator.center.x = (clickLabel?.center.x ?? 0)
        })
        self.delegate?.segmentItemDidClick(tag: clickLabel?.tag ?? 1000)
    }
    
    fileprivate func scrollViewNeedNotScroll(){
        topScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    fileprivate func scrollViewScrollToPoint(_ point:CGPoint){
        topScrollView.setContentOffset(point, animated: true)
    }
    
}

class CustomAnimationLabel: UILabel {
    
    open var isSelected :Bool = false {
        didSet{
            self.scale = (isSelected ? 1.0 : 0.0)
            
            if isSelected {
                self.textColor = selectColor
            }else{
                self.textColor = normalColor
            }
            
            self.font = (isSelected ?
                UIFont.boldSystemFont(ofSize: 18):
                UIFont.systemFont(ofSize: 18))
            let trueScale: CGFloat = isSelected ? 1.1 : 1.0
            self.transform = CGAffineTransform(scaleX: trueScale, y: trueScale)
        }
    }
    
    fileprivate var scale :CGFloat = 0.0 {
        didSet{
            //Extension other Property With scale
            // ......
        }
    }
    
    var selectColor = UIColor.red
    var normalColor = UIColor.black {
        didSet{
            self.textColor = normalColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textAlignment = .center
        self.isSelected = false
        self.isUserInteractionEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}







