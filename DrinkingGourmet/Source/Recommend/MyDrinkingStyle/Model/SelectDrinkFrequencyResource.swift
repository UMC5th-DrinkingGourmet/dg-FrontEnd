//
//  SelectDrinkFrequencyResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/6/24.
//

import UIKit

struct SelectDrinkFrequencyResource {
    
    private let frequencyButtonTitle: [String] = [
        "월 2~3회",
        "주 1회",
        "주 2회",
        "주 4회 이상"
    ]
    
    func frequencyButtonTitleArray() -> [String] {
        return frequencyButtonTitle
    }
}
