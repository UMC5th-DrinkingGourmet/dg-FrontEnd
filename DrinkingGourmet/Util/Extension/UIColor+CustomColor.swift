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
    
    static let baseColor = BaseColors()
        
    struct BaseColors {
        let base01 = UIColor(named: "base-0100") ?? .black
        let base02 = UIColor(named: "base-0200") ?? .darkGray
        let base03 = UIColor(named: "base-0300") ?? .darkGray
        let base04 = UIColor(named: "base-0400") ?? .darkGray
        let base05 = UIColor(named: "base-0500") ?? .darkGray
        let base06 = UIColor(named: "base-0600") ?? .lightGray
        let base07 = UIColor(named: "base-0700") ?? .lightGray
        let base08 = UIColor(named: "base-0800") ?? .lightGray
        let base09 = UIColor(named: "base-0900") ?? .lightGray
        let base10 = UIColor(named: "base-1000") ?? .white
    }
}
