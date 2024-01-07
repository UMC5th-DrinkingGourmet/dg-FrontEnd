//
//  UITextField+AddPadding.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit

extension UITextField {
    func placeHolder(string: String, color: UIColor = .white) {
        self.attributedPlaceholder = NSAttributedString(
            string: string,
            attributes: [
                NSAttributedString.Key.foregroundColor : color
            ]
        )
    }
    
    func addLeftPadding(padding: CGFloat = 15) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
