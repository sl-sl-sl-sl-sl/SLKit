//
//  UIKit.swift
//  WeicoSL
//
//  Created by zhenyu li on 2016/12/27.
//  Copyright © 2016年 zhenyu li. All rights reserved.
//

import UIKit

public extension UIResponder {
    
    open func nearestResponder(`class`: AnyClass) -> UIResponder?{
        var responder: UIResponder? = self.next
        while responder != nil {
            if responder!.isKind(of: `class`) {
                return responder
            }
            responder = responder?.next
        }
        return nil
    }
    
    open func nearestViewController() -> UIViewController? {
        return self.nearestResponder(class: UIViewController.classForCoder()) as! UIViewController?
    }

    open func nearestNavigationController() -> UINavigationController? {
        return self.nearestResponder(class: UINavigationController.classForCoder()) as! UINavigationController?
    }
}

public extension UIColor {
    open static func random() -> UIColor {
        return UIColor.init(red: CGFloat(Double((0...255).random()))/255, green: CGFloat(Double((0...255).random()))/255, blue: CGFloat(Double((0...255).random()))/255, alpha: 1)
    }
    
    open convenience init(Hex: String) {
        var colorStr = Hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let length = colorStr.lengthOfBytes(using: .utf8)
        if length >= 8 {
            colorStr = colorStr.substring(to: colorStr.index(colorStr.startIndex, offsetBy: 8))
            let scanner = Scanner(string: colorStr)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let alpha = CGFloat(hexNumber & 0x000000ff)/255
                self.init(Hex:colorStr.substring(to: colorStr.index(colorStr.startIndex, offsetBy: 6)), alpha: alpha)
            } else {
                self.init(red: 0, green: 0, blue: 0, alpha: 1)
            }
        } else if length >= 6 {
            colorStr = colorStr.substring(to: colorStr.index(colorStr.startIndex, offsetBy: 6))
            self.init(Hex:colorStr, alpha:1)
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    open convenience init(Hex: String, alpha: CGFloat) {
        var colorString = Hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if colorString.lengthOfBytes(using: .utf8) > 6 {
            colorString = colorString.substring(to: colorString.index(colorString.startIndex, offsetBy: 6))
        }
        if colorString.lengthOfBytes(using: .utf8) == 6 {
            let scanner = Scanner(string: Hex)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let red = CGFloat((hexNumber & 0xff0000) >> 16)/255
                let green = CGFloat((hexNumber & 0x00ff00) >> 8)/255
                let blue = CGFloat(hexNumber & 0x0000ff)/255
                self.init(red: red, green: green, blue: blue, alpha: alpha)
            } else {
                self.init(red: 0, green: 0, blue: 0, alpha: 1)
            }
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}