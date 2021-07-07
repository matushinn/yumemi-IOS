//
//  ClassName.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
