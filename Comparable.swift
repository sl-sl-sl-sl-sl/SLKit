//
//  Comparable.swift
//  Pods
//
//  Created by zhenyu li on 2017/1/15.
//
//

import UIKit

class Version: Comparable {
    
    private let numbers: [Int]
    
    init?(_ version: String?) {
        var ns = [Int]()
        if let v = version {
            let numbers = v.components(separatedBy: ".")
            for n in numbers {
                guard let i = Int(n), i >= 0 else {
                    return nil
                }
                ns.append(i)
            }
        }
        if ns.count == 0 {
            return nil
        }
        self.numbers = ns
    }
    
    private static func versionCompare(_ lhs: Version, _ rhs: Version) -> ComparisonResult {
        let lhsCount = lhs.numbers.count
        let rhsCount = rhs.numbers.count
        let maxCount = max(lhsCount, rhsCount)
        var result = ComparisonResult.orderedSame
        for i in 0..<maxCount {
            var l = 0
            var r = 0
            if lhsCount > i {
                l = lhs.numbers[i]
            }
            if rhsCount > i {
                r = rhs.numbers[i]
            }
            if l == r {
                continue
            } else {
                if l > r {
                    result = ComparisonResult.orderedDescending
                } else {
                    result = ComparisonResult.orderedAscending
                }
                break
            }
        }
        return result
    }
    
    public static func == (lhs: Version, rhs: Version) -> Bool {
        return ComparisonResult.orderedSame == versionCompare(lhs, rhs)
    }
    
    public static func < (lhs: Version, rhs: Version) -> Bool {
        return ComparisonResult.orderedAscending == versionCompare(lhs, rhs)
    }
    
    public static func > (lhs: Version, rhs: Version) -> Bool {
        return ComparisonResult.orderedDescending == versionCompare(lhs, rhs)
    }
    
    public static func <= (lhs: Version, rhs: Version) -> Bool {
        return lhs < rhs || lhs == rhs
    }
    
    public static func >= (lhs: Version, rhs: Version) -> Bool {
        return lhs > rhs || lhs == rhs
    }
}
