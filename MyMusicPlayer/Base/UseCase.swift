//
//  UseCase.swift
//  Yjx2.0
//
//  Created by L Y on 2016/12/14.
//  Copyright © 2016年 Robert yao. All rights reserved.
//

import RxSwift

typealias ErrorHandler = (Error)->(Void)
typealias CompleteHandler = ()->(Void)

class UseCase<RequestValue,ResponeValue>{
    
    typealias NextHandler = (ResponeValue)->(Void)
    
    var disposable : Disposable?

    func execute(requestValue:RequestValue? = nil ,nextHandler: @escaping NextHandler , errorHandler : @escaping ErrorHandler, completeHandler : CompleteHandler? = nil){
    
        disposable = buildObservable(requestValue:requestValue)
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentMainScheduler.instance)
            .subscribe(onNext: nextHandler, onError: errorHandler, onCompleted: completeHandler)
        
    }
    
    func buildObservable(requestValue:RequestValue?) -> Observable<ResponeValue>{
        fatalError("You must override func buildObservable")
    }
    
    func unSubscribe(){
        disposable?.dispose()
    }
}


