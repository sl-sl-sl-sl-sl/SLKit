//
//  UIKit.swift
//  WeicoSL
//
//  Created by zhenyu li on 2016/12/27.
//  Copyright © 2016年 zhenyu li. All rights reserved.
//

import UIKit

public extension UIResponder {
    
    public func nearestResponder(`class`: AnyClass) -> UIResponder?{
        var responder: UIResponder? = self.next
        while responder != nil {
            if responder!.isKind(of: `class`) {
                return responder
            }
            responder = responder?.next
        }
        return nil
    }
    
    public func nearestViewController() -> UIViewController? {
        return self.nearestResponder(class: UIViewController.classForCoder()) as! UIViewController?
    }

    public func nearestNavigationController() -> UINavigationController? {
        return self.nearestResponder(class: UINavigationController.classForCoder()) as! UINavigationController?
    }
}

public extension UIColor {
    public static func random() -> UIColor {
        return UIColor.init(red: CGFloat(Double((0...255).random()))/255, green: CGFloat(Double((0...255).random()))/255, blue: CGFloat(Double((0...255).random()))/255, alpha: 1)
    }
    
    private static func filter(Hex: String) -> String {
        var colorStr = Hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if colorStr.hasPrefix("#") {
            colorStr = colorStr.replacingOccurrences(of: "#", with: "")
        } else if colorStr.hasPrefix("0x") {
            colorStr = colorStr.replacingOccurrences(of: "0x", with: "")
        } else if colorStr.hasPrefix("0X") {
            colorStr = colorStr.replacingOccurrences(of: "0X", with: "")
        }
        return colorStr
    }
    
    public convenience init(Hex: String) {
        var colorString = UIColor.filter(Hex: Hex)
        let length = colorString.lengthOfBytes(using: .utf8)
        if length >= 8 {
            colorString = colorString.substring(to: colorString.index(colorString.startIndex, offsetBy: 8))
            let scanner = Scanner(string: colorString)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let alpha = CGFloat(hexNumber & 0x000000ff)/255
                self.init(Hex:colorString.substring(to: colorString.index(colorString.startIndex, offsetBy: 6)), alpha: alpha)
            } else {
                self.init(red: 0, green: 0, blue: 0, alpha: 1)
            }
        } else if length >= 6 {
            colorString = colorString.substring(to: colorString.index(colorString.startIndex, offsetBy: 6))
            self.init(Hex:colorString, alpha:1)
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    public convenience init(Hex: String, alpha: CGFloat) {
        var colorString = UIColor.filter(Hex: Hex)
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

public extension UIApplication {
    private func applicationStatusBar() -> UIView {
        let privateKey = ["_", "status", "Bar"]
        return self.value(forKey: privateKey.joined()) as! UIView
    }
    
    public func showStatusBar(_ animation: Bool = true) {
        let statusBar = self.applicationStatusBar()
        if animation {
            UIView.animate(withDuration: 0.25, animations: { 
                statusBar.alpha = 1;
            })
        } else {
            statusBar.alpha = 1;
        }
    }
    
    public func hideStatusBar(_ animation: Bool = true) {
        let statusBar = self.applicationStatusBar()
        if animation {
            UIView.animate(withDuration: 0.25, animations: { 
                statusBar.alpha = 0;
            })
        } else {
            statusBar.alpha = 0;
        }
    }
}





