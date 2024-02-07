//
//  SelectDrinkCapacityResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/6/24.
//

import UIKit

struct SelectDrinkCapacityResource {
    private let capacityButtonImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "BTN_0.5"),
        UIImage(imageLiteralResourceName: "BTN_1"),
        UIImage(imageLiteralResourceName: "BTN_1.5"),
        UIImage(imageLiteralResourceName: "BTN_2.0")
    ]
    private let capacityButtonSelectedImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "BTN_0.5_selected"),
        UIImage(imageLiteralResourceName: "BTN_1_selected"),
        UIImage(imageLiteralResourceName: "BTN_1.5_selected"),
        UIImage(imageLiteralResourceName: "BTN_2.0_selected")
    ]
    
    func capacityButtonImageArray() -> [UIImage] {
        return capacityButtonImage
    }
    func capacityButtonSelectedImageArray() -> [UIImage] {
        return capacityButtonSelectedImage
    }
}
