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
    
    func attachView(_ view:ContentTableViewControllerInput){
        viewInput = view
    }
    
    init(useCase:ContentTableViewCase) {
        self.useCase = useCase
    }
    
    func requestTableViewContent(requestValue: ContentTableViewRequestValue?) {
        useCase.execute(requestValue: requestValue, nextHandler: { (model) in
            
        }, errorHandler: { (error:Error) in
            
        })
    }
    
}
