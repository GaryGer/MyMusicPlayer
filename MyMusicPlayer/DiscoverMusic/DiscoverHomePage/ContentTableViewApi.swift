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
//    func getResponseData() -> Observable<ContentTableViewModel>{
//        return provider.reques
//    }
}

enum ContentTableViewStatement {
    case ApiForContentTableView()
}

extension ContentTableViewStatement :TargetType{
    var baseURL: URL {
        return URL(string: "http://tingapi.ting.baidu.com")!
    }
    
    var path: String {
        return "/v1/restserver/ting"
    }
    
    var parameters :[String: Any]{
        return ["format":"json",
                "calback":"",
                "from":"webapp_music",
                "method":"baidu.ting.billboard.billList&type=1&size=10&offset=0"]
    }
    
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "[]".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestParameters(parameters: self.parameters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
