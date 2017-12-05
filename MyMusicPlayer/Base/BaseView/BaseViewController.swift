//
//  BaseViewController.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/4.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var navigationTitle :String? {
        didSet{
            self.navigationItem.title = navigationTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = ColorConversion(hexString: "f6f2f1", alpha: 1.0)
    }
    
    func setNavigationLeftButton(imageName:String?,action:Selector?){
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named:imageName ?? ""), style: .plain, target: self, action: action), animated: true)
    }
    func setNavigationLeftButton(title:String?,action:Selector?){
        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: title ?? "", style: .plain, target: self, action: action), animated: true)
    }
}
