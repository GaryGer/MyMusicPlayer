//
//  ContentTableViewPresenter.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/8.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import Foundation
import RxSwift

class ContentTableViewPresenter: ContentTableViewControllerOutput {
   
    var useCase:ContentTableViewCase!
    
    private weak var viewInput :ContentTableViewControllerInput?
    
    func attachView(view:ContentTableViewControllerInput){
        viewInput = view
    }
    
    init(useCase:ContentTableViewCase) {
        self.useCase = useCase
    }
    
    func requestTableViewContent(requestValue: ContentTableViewRequestValue?) {
        useCase.execute(requestValue: requestValue, nextHandler: { (model) in
            print(model.song_list ?? "default")
            self.viewInput?.getResponseValueSuccess(model: model)
        }, errorHandler: { (error:Error) in
            self.viewInput?.getResponseValueFaild()
        })
    }
    
}
