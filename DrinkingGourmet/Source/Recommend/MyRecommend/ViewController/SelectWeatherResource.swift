//
//  SelectWeatherResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/5/24.
//

import UIKit

struct SelectWeatherResource {
    
    private let weatherButtonImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "chip_weather1"),
        UIImage(imageLiteralResourceName: "chip_weather2"),
        UIImage(imageLiteralResourceName: "chip_weather3"),
        UIImage(imageLiteralResourceName: "chip_weather4"),
        UIImage(imageLiteralResourceName: "chip_weather5"),
        UIImage(imageLiteralResourceName: "chip_weather6"),
        UIImage(imageLiteralResourceName: "chip_weather7"),
        UIImage(imageLiteralResourceName: "chip_weather8"),
        UIImage(imageLiteralResourceName: "chip_weather9"),
        UIImage(imageLiteralResourceName: "chip_weather10"),
        UIImage(imageLiteralResourceName: "chip_weather11")
    ]
    
    private let weatherButtonSelectedImage: [UIImage] = [
        UIImage(imageLiteralResourceName: "chip_weather1_selected"),
        UIImage(imageLiteralResourceName: "chip_weather2_selected"),
        UIImage(imageLiteralResourceName: "chip_weather3_selected"),
        UIImage(imageLiteralResourceName: "chip_weather4_selected"),
        UIImage(imageLiteralResourceName: "chip_weather5_selected"),
        UIImage(imageLiteralResourceName: "chip_weather6_selected"),
        UIImage(imageLiteralResourceName: "chip_weather7_selected"),
        UIImage(imageLiteralResourceName: "chip_weather8_selected"),
        UIImage(imageLiteralResourceName: "chip_weather9_selected"),
        UIImage(imageLiteralResourceName: "chip_weather10_selected"),
        UIImage(imageLiteralResourceName: "chip_weather11_selected")
    ]
    
    func weatherButtonImageArray() -> [UIImage] {
        return weatherButtonImage
    }
    func weatherButtonSelectedImageArray() -> [UIImage] {
        return weatherButtonSelectedImage
    }
}

