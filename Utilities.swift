//
//  Utilities.swift
//  WeicoSL
//
//  Created by zhenyu li on 2017/1/3.
//  Copyright © 2017年 zhenyu li. All rights reserved.
//

import UIKit


// MARK: - PrintFunction
public func prettyFunction(file:String = #file, function:String = #function, line:Int = #line) -> String {
    return "file:\(file.trimmingCharacters(in: CharacterSet(charactersIn: "/")).components(separatedBy: "/").last!) function:\(function) line:\(line)"
}

// MARK: - Transformation
public final class TypeTransform<T, M> {
    public static func transform(i:T?) -> M? {
        guard let t = i else {
            return nil
        }
        if M.self == Int.self {
            let s = String(describing: t)
            if let d = Double(s) {
                return Int(d) as? M
            }
        }
        else if M.self == Int64.self {
            let s = String(describing: t)
            if let d = Double(s) {
                return Int64(d) as? M
            }
        }
        else if M.self == Double.self {
            let s = String(describing: t)
            if let d = Double(s) {
                return d as? M
            }
        }
        else if M.self == Float.self {
            let s = String(describing: t)
            if let d = Double(s) {
                return Float(d) as? M
            }
        }
        else if M.self == CGFloat.self {
            let s = String(describing: t)
            if let d = Double(s) {
                return CGFloat(d) as? M
            }
        }
        else if M.self == Bool.self {
            let s = String(describing: t)
            if let i = Int(s) {
                switch i {
                case 0:
                    return false as? M
                case 1:
                    return true as? M
                default:
                    return nil
                }
            }
        }
        return nil
    }
}
