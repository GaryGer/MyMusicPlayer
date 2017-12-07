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

protocol SegmentDelegate {
    func segmentItemDidClick(tag:Int)
}

class SegmentControl: UIControl {
    
    fileprivate var labelWidth :CGFloat = 100.0
    fileprivate var labelHeight :CGFloat = 40
    fileprivate var labelY :CGFloat = 0.0
    
    fileprivate var items :[String] = []
    
    fileprivate lazy var topScrollView :UIScrollView = {
        let topScrView = UIScrollView()
        topScrView.backgroundColor = UIColor.red
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
        if CGFloat(self.items.count) * labelWidth < Swidth {
            labelWidth = Swidth / CGFloat(self.items.count)
            creatLabels(labelWidth)
        }else{
            labelWidth = 100.0
            creatLabels(labelWidth)
        }
    }
    
    fileprivate func creatLabels(_ labelWidth:CGFloat){
        for i in 0..<self.items.count {
            let customLabel = CustomAnimationLabel(frame: CGRect(x: CGFloat(i) * labelWidth, y: 0, width: labelWidth, height: labelHeight))
            customLabel.text = items[i]
            customLabel.textAlignment = .center
            customLabel.font = UIFont(name: "HYQiHei", size: 19)
            topScrollView.addSubview(customLabel)
            customLabel.tag = i
            customLabel.isUserInteractionEnabled = true
            customLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(customLabelClick(recognizer:))))
            
        }
        topScrollView.contentSize = CGSize(width: CGFloat(self.items.count) * labelWidth, height: 0)
    }
    
    @objc fileprivate func customLabelClick(recognizer:UITapGestureRecognizer){
        let clickLabel = recognizer.view as? CustomAnimationLabel
        
        print(clickLabel?.tag ?? "0000")
    }
    
}










