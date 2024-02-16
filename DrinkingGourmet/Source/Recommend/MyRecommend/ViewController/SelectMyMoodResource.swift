//
//  SelectMyMoodResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/5/24.
//

import UIKit

struct SelectMyMoodResource {
    
    private let moodButtonImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "chip_emotion1"),
        UIImage(imageLiteralResourceName: "chip_emotion2"),
        UIImage(imageLiteralResourceName: "chip_emotion3"),
        UIImage(imageLiteralResourceName: "chip_emotion4"),
        UIImage(imageLiteralResourceName: "chip_emotion5"),
        UIImage(imageLiteralResourceName: "chip_emotion6"),
        UIImage(imageLiteralResourceName: "chip_emotion7"),
        UIImage(imageLiteralResourceName: "chip_emotion8"),
        UIImage(imageLiteralResourceName: "chip_emotion9"),
        UIImage(imageLiteralResourceName: "chip_emotion10"),
        UIImage(imageLiteralResourceName: "chip_emotion11")
    ]
    
    private let moodButtonSelectedImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "chip_emotion1_selected"),
        UIImage(imageLiteralResourceName: "chip_emotion2_selected"),
        UIImage(imageLiteralResourceName: "chip_emotion3_selected"),
        UIImage(imageLiteralResourceName: "chip_emotion4_selected"),
        UIImage(imageLiteralResourceName: "chip_emotion5_selected"),
        UIImage(imageLiteralResourceName: "chip_emotion6_selected"),
        UIImage(imageLiteralResourceName: "chip_emotion7_selected"),
        UIImage(imageLiteralResourceName: "chip_emotion8_selected"),
        UIImage(imageLiteralResourceName: "chip_emotion9_selected"),
        UIImage(imageLiteralResourceName: "chip_emotion10_selected"),
        UIImage(imageLiteralResourceName: "chip_emotion11_selected")
    ]
    
    func moodButtonImageArray() -> [UIImage] {
        return moodButtonImage
    }
    func moodButtonSelectedImageArray() -> [UIImage] {
        return moodButtonSelectedImage
    }
}
