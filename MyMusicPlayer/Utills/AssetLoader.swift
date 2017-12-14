//
//  AssetLoader.swift
//  DownloadDemo
//
//  Created by Ger on 2017/11/15.
//  Copyright © 2017年 UEZ. All rights reserved.
//

import UIKit
import Moya
import Alamofire
import RxSwift
import ObjectMapper

class AssetLoader {
    
    static let `default` = AssetLoader()
    let provider = MoyaProvider<DownLoadAsset>(plugins: [NetworkLoggerPlugin(verbose: true)])
    private init(){}
    
    func load(asset:DownLoadAsset,completion:((Result<Any>) -> Void)? = nil){
        if FileManager.default.fileExists(atPath: asset.localLocation.path) {
            completion?(.success(asset.localLocation))
            return
        }
        provider.request(asset) { result in
            switch result {
            case .success:
                completion?(.success(asset.localLocation))
            case let .failure(error):
                completion?(.failure(error))
            }
        }
    }
    
}


enum DownLoadAsset {
    //枚举定义api
    //参数： 下载url，bundle版本号，app版本
    case JSBundle(downLoadUrl: String)
}

extension DownLoadAsset : TargetType{
    var headers: [String : String]? {
        return nil
    }
    
    var assetName: String {
        switch self {
            case .JSBundle(_): return "ios.lrc"
        }
    }
    
    //默认下载保存地址（用户文档目录）
    var assetDir: URL {
        let directoryURLs = FileManager.default.urls(for: .documentDirectory,
                                                     in: .userDomainMask)
        return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    //获取对应的资源文件本地存放路径
    var localLocation: URL {
        return assetDir.appendingPathComponent(assetName)
    }
    
    public var baseURL : URL {
       return URL(string : "http://musicdata.baidu.com/data2/lrc/6ce9fb402254c7173f495bec7f855fbb/566879821/566879821.lrc")!
    }
    
    public var path : String{
        return ""
    }
    
    
    public var method : Moya.Method{
        
        return .get
    }
    
    public var parameters : [String : Any]?{
        return nil
    }
    
    public var sampleData : Data {
        return "{}".data(using:String.Encoding.utf8)!
    }
    
    //定义一个DownloadDestination
    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, .removePreviousFile) }
    }
    
    //请求任务事件
    public var task: Task {
        return .downloadDestination(downloadDestination)
    }
}
