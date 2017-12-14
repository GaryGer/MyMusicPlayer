// Provider.swift
// RxCache
//
// Copyright (c) 2016 Victor Albertos https://github.com/VictorAlbertos
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

/**
Allows to configure how the data should be cached.
This protocol must be implemented using the enumeration pattern.
*/
public protocol Provider {
    var lifeCache : LifeCache? {get}
    
    var dynamicKey : DynamicKey? {get}
    var dynamicKeyGroup : DynamicKeyGroup? {get}
    
    var evict : EvictProvider? {get}
    
    func expirable() -> Bool
    
    var providerKey: String {get}
}

public extension Provider {
    
    func expirable() -> Bool {
        return true
    }
}

public extension Provider {
    
    var providerKey: String {
        return nameStripingInitArguments()
    }
    
    internal func nameStripingInitArguments() -> String {
        let target: String = String(describing: self)
        if let idx = target.characters.index(of: "(") {
            return target.substring(to: idx)
        }
        return target
    }
    
}


