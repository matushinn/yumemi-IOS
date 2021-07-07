//
//  UIColor.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//
import UIKit

extension UIColor {
    convenience init?(hexString: String) {
        let hexString = hexString.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexString)
        scanner.currentIndex = scanner.string.startIndex
        var color: UInt64 = 0
        if scanner.scanHexInt64(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0xFF00) >> 8) / 255.0
            let b = CGFloat(color & 0xFF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: 1)
            return
        }
        return nil
    }
}
