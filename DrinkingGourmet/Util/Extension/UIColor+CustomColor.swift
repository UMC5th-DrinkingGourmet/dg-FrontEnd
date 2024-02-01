//
//  UIColor+CustomColor.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit

extension UIColor {
    static let customColor = CustomColors()
    
    struct CustomColors {
        let customOrange = UIColor(named: "CustomOrange") ?? .orange
        let checkMarkGray = UIColor(named: "CheckmarkGray") ?? .gray
    }
}
