//
//  Extensions.swift
//  Wtest
//
//  Created by Pedro Del Rio Ortiz on 30/04/22.
//

import Foundation
import UIKit

extension ViewConfiguration {
    func initialize() {
        addViews()
        addConstraints()
    }
}

extension UILabel {
    func applyStyle(color: UIColor, fontName: FontName, size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = color
        font = UIFont(name: fontName.rawValue, size: size)
    }
}
