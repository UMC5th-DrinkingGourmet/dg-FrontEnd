//
//  UIView+addSubViews.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
    
    func addSubviewsToContentView(contentView: UIView, _ views: [UIView]) {
        views.forEach {
            contentView.addSubview($0)
        }
    }
}
