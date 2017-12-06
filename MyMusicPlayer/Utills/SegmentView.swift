//
//  SegmentView.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/6.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit

protocol SegmentDelegate {
    func segmentItemDidClick(tag:Int)
}


class SegmentView: UIControl {
    
    fileprivate var items :[String] = []
    
    init(items:[String]){
        self.items = items
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.items = []
        super.init(coder: aDecoder)
    }
    
}
