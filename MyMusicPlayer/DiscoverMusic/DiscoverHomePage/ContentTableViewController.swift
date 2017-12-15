//
//  ContentTableViewController.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/8.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit

protocol ContentTableViewControllerInput :class{
    func getResponseValueSuccess(model: SongList?)
    func getResponseValueFaild()
}

protocol ContentTableViewControllerOutput {
    func attachView(view:ContentTableViewControllerInput)
    func requestTableViewContent(requestValue:ContentTableViewRequestValue?)
}

class ContentTableViewController: UITableViewController,ContentTableViewControllerInput {

    var viewOutput : ContentTableViewControllerOutput?
    
    var refresh = false {
        didSet{
            if refresh {
//                viewOutput?.requestTableViewContent(requestValue: ContentTableViewRequestValue())
            }
        }
    }
    
    fileprivate lazy var modelList:[ContentTableViewModel]? = {
        let list = [ContentTableViewModel]()
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUseCase()
        registerCell()
    }
    fileprivate func registerCell(){
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "reuseIdentifier")
    }

    fileprivate func configUseCase(){
        let api = ContentTableViewApi()
        let repo = ContentTableViewRepository(api: api)
        let useCase = ContentTableViewCase(repo: repo)
        viewOutput = ContentTableViewPresenter(useCase: useCase)
        viewOutput?.attachView(view: self)
    }
    
    func getResponseValueSuccess(model: SongList?) {
        if (modelList?.isEmpty ?? false) == false {
            modelList?.removeAll()
        }
        if let optionModel = model {
            modelList = optionModel.song_list
        }
        self.tableView.reloadData()
    }
    
    func getResponseValueFaild(){
        print("Request Faild")
    }

}

extension ContentTableViewController{
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modelList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "reuseIdentifier"
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! TableViewCell
        cell.songTitle.text = modelList?[indexPath.row].title
        cell.songDetailTitle?.text = modelList?[indexPath.row].publishtime
        cell.songIconUrl = modelList?[indexPath.row].pic_small
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}














