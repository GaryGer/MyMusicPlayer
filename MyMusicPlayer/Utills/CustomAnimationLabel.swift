//
//  CustomAnimationLabel.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/7.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit

class CustomAnimationLabel: UILabel {

    var scale :CGFloat = 0.0 {
        didSet(newValue){
            self.textColor = UIColor(red: newValue, green: 0.0, blue: 0.0, alpha: 1)
            let minScale: CGFloat = 0.7
            let trueScale: CGFloat = minScale + (1 - minScale)*newValue
            self.transform = CGAffineTransform(scaleX: trueScale, y: trueScale)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont.systemFont(ofSize: 18)
        scale = 0.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
