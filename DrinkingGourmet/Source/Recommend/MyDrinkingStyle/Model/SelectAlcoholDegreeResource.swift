//
//  SelectAlcoholDegreeResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/6/24.
//

import UIKit

struct SelectAlcoholDegreeResource {
    
    private let alcoholDegreeButtonTitle: [String] = [
        "5도",
        "10도",
        "15도",
        "20도",
        "30도",
        "40도"
    ]

    func alcoholDegreeButtonTitleArray() -> [String] {
        return alcoholDegreeButtonTitle
    }
}
