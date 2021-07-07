//
//  Injectable.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

public protocol Injectable {
    associatedtype Dependency = Void
    func inject(_ dependency: Dependency)
}

public extension Injectable where Dependency == Void {
    func inject(_ dependency: Dependency) {
    }
}
