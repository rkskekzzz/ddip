//
//  extensions.swift
//  ProjectDDIP
//
//  Created by kyuhkim on 2021/09/20.
//

import Foundation
import UIKit
import MapKit

// MARK: - UIColor

extension UIColor {
    func exchangeToColor(hex: Int) -> UIColor {
        return UIColor(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
