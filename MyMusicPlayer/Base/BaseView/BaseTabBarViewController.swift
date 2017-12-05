//
//  BaseTabBarViewController.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/4.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    var titles = ["发现音乐","我的音乐","动态","账户"]
    var normalIcon :[String] = ["discMusicNormal","myMusicNormal","dynamicNormal","accountNormal"]
    var selectedIcon :[String] = ["discMusicSelect","myMusicSelect","dynamicSelect","accountSelect"]
    
    var VCList = [DiscoverMusicViewController(),MyMusicViewController(),DynamicViewController(),AccountViewController()]
    var NavVCList :[BaseNavigationController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configViewControllers()
    }
    
    private func configViewControllers(){
        
        for item in VCList {
            let nav = BaseNavigationController(rootViewController: item)
            NavVCList.append(nav)
        }
        viewControllers = NavVCList
        setChildViewControllersContent()
    }
    
    private func setChildViewControllersContent(){
        for i in 0..<titles.count {
            let item = self.tabBar.items?[i]
            item?.title = titles[i]
            item?.image = UIImage(named: normalIcon[i])?.withRenderingMode(.alwaysOriginal)
            item?.selectedImage = UIImage(named: selectedIcon[i])?.withRenderingMode(.alwaysOriginal)
            item?.setTitleTextAttributes([NSForegroundColorAttributeName :ColorConversion(hexString: "000000", alpha: 0.8),NSFontAttributeName:UIFont.systemFont(ofSize: 10)], for: .normal)
            item?.setTitleTextAttributes([NSForegroundColorAttributeName :ColorConversion(hexString: "405783", alpha: 1.0),NSFontAttributeName:UIFont.systemFont(ofSize: 10)], for: .selected)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
