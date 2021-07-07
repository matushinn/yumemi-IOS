//
//  CellReusable.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

public protocol CellReusable: NSObjectProtocol {
    static var reuseIdentifier: String { get }
}

public extension CellReusable {
    static var reuseIdentifier: String {
        return Self.className
    }
}

public typealias ReusableTableCell = UITableViewCell & CellReusable
public extension UITableView {
    func register<T: ReusableTableCell>(cellType: T.Type) {
        let nib = UINib(nibName: T.reuseIdentifier, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: ReusableTableCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }

    func dequeueReusableCell<T: ReusableTableCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }

    func cellForRow<T: ReusableTableCell>(at indexPath: IndexPath, cellType: T) -> T? {
        return cellForRow(at: indexPath) as? T
    }
}
