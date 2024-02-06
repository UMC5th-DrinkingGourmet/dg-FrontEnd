//
//  GradientView.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/6/24.
//

import UIKit


class GradientView: UIView {
    override open class var layerClass: AnyClass {
       return CAGradientLayer.classForCoder()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        guard let gradientLayer = self.layer as? CAGradientLayer else { return }
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.1, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.1, y: 0.0)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
