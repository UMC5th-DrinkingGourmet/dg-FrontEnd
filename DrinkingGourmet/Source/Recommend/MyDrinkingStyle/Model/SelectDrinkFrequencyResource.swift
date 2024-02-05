//
//  SelectDrinkFrequencyResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/6/24.
//

import UIKit

struct SelectDrinkFrequencyResource {
    private let frequencyButtonImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "BTN_m2"),
        UIImage(imageLiteralResourceName: "BTN_w1"),
        UIImage(imageLiteralResourceName: "BTN_w2"),
        UIImage(imageLiteralResourceName: "BTN_w4")
    ]
    private let frequencyButtonSelectedImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "BTN_m2_selected"),
        UIImage(imageLiteralResourceName: "BTN_w1_selected"),
        UIImage(imageLiteralResourceName: "BTN_w2_selected"),
        UIImage(imageLiteralResourceName: "BTN_w4_selected")
    ]
    
    func frequencyButtonImageArray() -> [UIImage] {
        return frequencyButtonImage
    }
    func frequencyButtonSelectedImageArray() -> [UIImage] {
        return frequencyButtonSelectedImage
    }
}
