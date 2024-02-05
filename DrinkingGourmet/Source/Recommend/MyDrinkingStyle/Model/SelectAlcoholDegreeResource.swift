//
//  SelectAlcoholDegreeResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/6/24.
//

import UIKit

struct SelectAlcoholDegreeResource {
    private let alcoholDegreeButtonImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "BTN_5"),
        UIImage(imageLiteralResourceName: "BTN_10"),
        UIImage(imageLiteralResourceName: "BTN_15"),
        UIImage(imageLiteralResourceName: "BTN_20"),
        UIImage(imageLiteralResourceName: "BTN_30"),
        UIImage(imageLiteralResourceName: "BTN_40")
    ]
    private let alcoholDegreeButtonSelectedImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "BTN_5_selected"),
        UIImage(imageLiteralResourceName: "BTN_10_selected"),
        UIImage(imageLiteralResourceName: "BTN_15_selected"),
        UIImage(imageLiteralResourceName: "BTN_20_selected"),
        UIImage(imageLiteralResourceName: "BTN_30_selected"),
        UIImage(imageLiteralResourceName: "BTN_40_selected")
    ]
    
    func alcoholDegreeButtonImageArray() -> [UIImage] {
        return alcoholDegreeButtonImage
    }
    func alcoholDegreeButtonSelectedImageArray() -> [UIImage] {
        return alcoholDegreeButtonSelectedImage
    }
}
