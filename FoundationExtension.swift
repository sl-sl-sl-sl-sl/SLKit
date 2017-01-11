//
//  FoundationExtension.swift
//  WeicoSL
//
//  Created by zhenyu li on 2016/12/27.
//  Copyright © 2016年 zhenyu li. All rights reserved.
//

import UIKit

// MARK: - Collection Random
public extension RandomAccessCollection {
    /// return random between access collection
    ///
    ///     (1...10).random()
    ///     print one number between 1 ~ 10
    public func random() -> Iterator.Element {
        let offset = arc4random_uniform(numericCast(count))
        let i = index(startIndex, offsetBy: numericCast(offset))
        return self[i]
    }
}

// MARK: - ExecuteOnce
private var AssociatedObjectKey: UInt8 = 0

public extension NSObject {
    
    public var executionOnceInfo: [String : Bool]? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectKey) as? [String : Bool]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
    }
    
    /// execute once in instance until it deinit.
    ///
    /// - Parameters:
    ///   - code: the execute code in here.
    ///   - file: defalut
    ///   - function: defalut
    ///   - line: defalut
    public func executeOnce(_ code: (() -> ()), file:String = #file, function:String = #function, line:Int = #line) {
        
        let token = "file:\(file.trimmingCharacters(in: CharacterSet(charactersIn: "/")).components(separatedBy: "/").last!) function:\(function) line:\(line)"
        
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        let executed = self.executionOnceInfo?[token] ?? false
        if !executed {
            code()
            var executionOnceInfo = self.executionOnceInfo ?? [String : Bool]()
            executionOnceInfo[token] = true
            self.executionOnceInfo = executionOnceInfo
        }
    }
}


