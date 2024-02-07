//
//  SelectTypeOfLiquorResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/6/24.
//

import UIKit

struct SelectTypeOfLiquorResource {
    private let liquorTypeButtonImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "BTN_soju"),
        UIImage(imageLiteralResourceName: "BTN_beer"),
        UIImage(imageLiteralResourceName: "BTN_wine"),
        UIImage(imageLiteralResourceName: "BTN_sake"),
        UIImage(imageLiteralResourceName: "BTN_whiskey")
    ]
    private let liquorTypeButtonSelectedImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "BTN_soju_selected"),
        UIImage(imageLiteralResourceName: "BTN_beer_selected"),
        UIImage(imageLiteralResourceName: "BTN_wine_selected"),
        UIImage(imageLiteralResourceName: "BTN_sake_selected"),
        UIImage(imageLiteralResourceName: "BTN_whiskey_selected")
    ]
    
    func liquorTypeButtonImageArray() -> [UIImage] {
        return liquorTypeButtonImage
    }
    func liquorTypeButtonSelectedImageArray() -> [UIImage] {
        return liquorTypeButtonSelectedImage
    }
}
