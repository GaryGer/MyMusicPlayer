//
//  WellcomeViewController.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/4.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit

class WellcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 20, y: 50, width: 50, height: 50)
        btn.backgroundColor = UIColor.red
        btn.setTitle("跳过", for: .normal)
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(jumpButtonClick(sender:)), for: .touchUpInside)
        view.addSubview(btn)
    }
    
    @objc private func jumpButtonClick(sender:UIButton){
        navigationController?.pushViewController(BaseTabBarViewController(), animated: true)
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
