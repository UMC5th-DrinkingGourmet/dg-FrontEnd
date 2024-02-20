//
//  SelectWeatherResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/5/24.
//

import UIKit

struct SelectWeatherResource {
    
    private let weatherButtonTitle: [String] = [
        "화창해요",
        "맑아요",
        "흐려요",
        "바람이 불어요",
        "우중충해요",
        "비가 와요",
        "눈이 와요",
        "소나기가 내려요",
        "추워요",
        "따듯해요",
        "더워요"
    ]

    func weatherButtonTitleArray() -> [String] {
        return weatherButtonTitle
    }
}

