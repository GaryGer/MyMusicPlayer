//
//  UseCase.swift
//  MyMusicPlayer
//
//  Created by Ger on 2017/12/8.
//  Copyright © 2017年 GpfYxh.Ger.com. All rights reserved.
//

import RxSwift

typealias ErrorHandler = (Error) -> ()
typealias CompeleteHandler = () -> ()

class UseCase<RequestValue,ResponseValue> {

    typealias NextHandler = (ResponseValue) -> ()
    
    var disposeable :Disposable?
    
    func execute(requestValue:RequestValue? = nil, nextHandler: @escaping NextHandler,errorHandler:@escaping ErrorHandler,compeleteHandler:CompeleteHandler? = nil){
        
        disposeable = buildObservable(requestValue: requestValue)
                    .observeOn(MainScheduler.instance)
                    .subscribeOn(CurrentThreadScheduler.instance)
                    .subscribe(onNext: nextHandler, onError: errorHandler, onCompleted: compeleteHandler)
        
    }
    
    func buildObservable(requestValue:RequestValue?) -> Observable<ResponseValue>{
        fatalError("must override func buildObservable")
    }
    
    func unSubscribe(){
        disposeable?.dispose()
    }
}
