//
//  LRCListViewController.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/21.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit

class SongDetailViewController: BaseViewController {
    
    fileprivate lazy var lrcTableView :UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    fileprivate lazy var LrcProCessor :LRCProcessor? = {
        let lrcP = LRCProcessor()
        return lrcP
    }()
    
    var songId:String?{
        didSet{
//            self.navigationTitle = lrcTitle
            
//            AssetLoader.default.load(asset: .LoadLRC(downLoadUrl: modelList?[indexPath.row].lrclink ?? "")) { (result) in
//                switch result {
//                case .success(let localLocation):
//                    if FileManager.default.fileExists(atPath: (localLocation as AnyObject).path) {
//                        let str = try? String(contentsOf: localLocation as! URL)
//                        
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//            }
        }
    }
    
    var lrcStr :String?{
        didSet{
            LrcProCessor?.setMaterials(lrcStr)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lrcTableView)
    }
}

extension SongDetailViewController :UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LrcProCessor?.getTimeArray()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseCell")
        }
        cell?.textLabel?.text = LrcProCessor?.getWordArray()?[indexPath.row]
        cell?.textLabel?.textAlignment = .center
        cell?.selectionStyle = .none
        return cell!
    }
}











