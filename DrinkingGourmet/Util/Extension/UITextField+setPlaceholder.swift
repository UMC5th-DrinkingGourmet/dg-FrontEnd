//
//  UITextField+setPlaceholder.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/19/24.
//

import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
