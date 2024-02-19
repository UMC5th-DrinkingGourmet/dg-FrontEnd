//
//  SelectDrinkCapacityResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/6/24.
//

import UIKit

struct SelectDrinkCapacityResource {
    
    private let capacityButtonTitle: [String] = [
        "반 병 이하",
        "한 병",
        "1병 반",
        "2병 이상"
    ]

    func capacityButtonTitleArray() -> [String] {
        return capacityButtonTitle
    }
}
