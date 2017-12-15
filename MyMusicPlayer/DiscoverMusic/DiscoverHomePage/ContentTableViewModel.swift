//
//  ContentTableViewModel.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/8.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import UIKit
import ObjectMapper
import RxCache

class SongList :Mappable,OMCacheable{
    var song_list :[ContentTableViewModel]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        song_list <- map["song_list"]
    }
}

class ContentTableViewModel:Mappable,OMCacheable{
    var song_id :String?
    var title :String?
    var author :String?
    var pic_small :String?
    var pic_big :String?
    var language :String?
    var publishtime :String?
    var album_title :String?
    var album_id :String?
    var lrclink :String?
    var country :String?
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        song_id <- map["song_id"]
        title <- map["title"]
        author <- map["author"]
        pic_small <- map["pic_small"]
        pic_big <- map["pic_big"]
        language <- map["language"]
        publishtime <- map["publishtime"]
        album_title <- map["album_title"]
        album_id <- map["album_id"]
        lrclink <- map["lrclink"]
        country <- map["country"]
    }
}
