//
//  ContentTableViewController.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/8.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit

protocol ContentTableViewControllerInput :class{
    func getResponseValueSuccess(responseValue:ContentTableViewModel?)
}

protocol ContentTableViewControllerOutput :class {
    func requestTableViewContent(requestValue:ContentTableViewRequestValue?)
}

class ContentTableViewController: UITableViewController,ContentTableViewControllerInput {

    var refresh = false {
        didSet{
            if refresh {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getResponseValueSuccess(responseValue: ContentTableViewModel?) {
        
    }

}

extension ContentTableViewController{
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "reuseCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        cell?.textLabel?.text = "就是我"
        
        return cell!
    }
    
}














