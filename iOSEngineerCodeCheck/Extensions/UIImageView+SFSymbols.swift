//
//  UIImageView+SFSymbols.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(systemName: String, tintColor: UIColor) {
        self.image = UIImage(systemName: systemName)
        self.tintColor = tintColor
    }
}

