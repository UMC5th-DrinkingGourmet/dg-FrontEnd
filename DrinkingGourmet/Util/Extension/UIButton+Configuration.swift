//
//  UIButton+Configuration.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 1/6/24.
//

import UIKit

extension UIImage {
    func resizedImage(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIButton {
    func buttonConfiguration(title: String, font: UIFont, foregroundColor: UIColor, padding: Int, image: UIImage?, imageSize: CGSize) {
        let resizedImg = image?.resizedImage(to: imageSize)
        
        var config = UIButton.Configuration.plain()
        config.image = resizedImg
        config.imagePadding = CGFloat(padding)
        config.imagePlacement = .leading

        var titleAttr = AttributedString.init(title)
        titleAttr.foregroundColor = foregroundColor
        titleAttr.font = font
        config.attributedTitle = titleAttr
        config.baseForegroundColor = foregroundColor
        self.backgroundColor = .clear
        self.configuration = config
    }
    
    func trailingBtnConfiguration(title: String, font: UIFont, foregroundColor: UIColor, padding: Int, image: UIImage?, imageSize: CGSize) {
        let resizedImg = image?.resizedImage(to: imageSize)
        
        var config = UIButton.Configuration.plain()
        config.image = resizedImg
        config.imagePadding = CGFloat(padding)
        config.imagePlacement = .trailing

        var titleAttr = AttributedString.init(title)
        titleAttr.foregroundColor = foregroundColor
        titleAttr.font = font
        config.attributedTitle = titleAttr
        config.baseForegroundColor = foregroundColor
        self.backgroundColor = .clear
        
        self.configuration = config
    }
    
    func genderBtnConfig(title: String, font: UIFont, foregroundColor: UIColor, borderColor: UIColor) {
        var config = UIButton.Configuration.plain()
        
        var titleAttr = AttributedString.init(title)
        titleAttr.foregroundColor = foregroundColor
        titleAttr.font = font
        
        config.attributedTitle = titleAttr
        config.baseForegroundColor = foregroundColor
        
        self.backgroundColor = .clear
        self.configuration = config
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
    }
    
    func goBtnConfig(title: String, font: UIFont, backgroundColor: UIColor) {
        var config = UIButton.Configuration.plain()
        
        var titleAttr = AttributedString.init(title)
        titleAttr.foregroundColor = .white
        titleAttr.font = font
        
        config.attributedTitle = titleAttr
        config.baseForegroundColor = .white
        
        self.backgroundColor = backgroundColor
        self.configuration = config
        self.layer.cornerRadius = 8
    }
    
    func logoutBtnConfig(title: String, font: UIFont, backgroundColor: UIColor) {
        var config = UIButton.Configuration.plain()
        
        var titleAttr = AttributedString.init(title)
        titleAttr.foregroundColor = .darkGray
        titleAttr.font = font
        
        config.attributedTitle = titleAttr
        config.baseForegroundColor = .white
        
        self.backgroundColor = backgroundColor
        self.configuration = config
    }
}
