//
//  ContentTableViewCase.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/8.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import RxSwift

class ContentTableViewCase: UseCase<ContentTableViewRequestValue, ContentTableViewModel> {
    
    var repo :ContentTableViewRepository!
    
    init(repo:ContentTableViewRepository) {
        self.repo = repo
    }
    
    override func buildObservable(requestValue: ContentTableViewRequestValue?) -> Observable<ContentTableViewModel> {
        return repo.requestTableViewContent()
    }
}
