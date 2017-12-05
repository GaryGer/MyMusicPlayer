//
//  UIColor_Extension.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/5.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit
func ColorConversion(hexString:NSString,alpha:CGFloat) -> UIColor {
    var str:NSString = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
    if hexString.hasPrefix("#"){
        str = (hexString as NSString).substring(from: 1) as NSString
    }
    
    let redStr = (str as NSString ).substring(to: 2)
    let greenStr = ((str as NSString).substring(from: 2) as NSString).substring(to: 2)
    let blueStr = ((str as NSString).substring(from: 4) as NSString).substring(to: 2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string:redStr).scanHexInt32(&r)
    Scanner(string: greenStr).scanHexInt32(&g)
    Scanner(string: blueStr).scanHexInt32(&b)
    
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
}
extension UIColor {
    
}
