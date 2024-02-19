//
//  SelectTypeOfLiquorResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/6/24.
//

import UIKit

struct SelectTypeOfLiquorResource {
    
    private let liquorTypeButtonTitle: [String] = [
        "소주",
        "맥주",
        "와인",
        "사케",
        "위스키"
    ]
    
    func liquorTypeButtonTitleArray() -> [String] {
        return liquorTypeButtonTitle
    }
}
