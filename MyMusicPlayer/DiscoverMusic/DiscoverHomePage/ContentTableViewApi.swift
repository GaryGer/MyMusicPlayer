//
//  ContentTableViewApi.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/8.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import RxSwift
import Moya

class ContentTableViewApi {
    let provider = MoyaProvider<ContentTableViewStatement>()
    
}

enum ContentTableViewStatement {
    case ApiForContentTableView()
}

extension ContentTableViewStatement :TargetType{
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "[]".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
