//
//  ContentTableViewRepository.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/8.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import RxSwift

protocol ContentRepositoryProtocol {
    func requestTableViewContent() -> Observable<SongList>
}

class ContentTableViewRepository :ContentRepositoryProtocol{
    var api :ContentTableViewApi!
    
    init(api:ContentTableViewApi?) {
        self.api = api
    }
    
    func requestTableViewContent() -> Observable<SongList> {
        return api.getResponseData()
    }
    
    
}
