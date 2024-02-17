//
//  SelectMyMoodResource.swift
//  DrinkingGourmet
//
//  Created by hee on 2/5/24.
//

import UIKit

struct SelectMyMoodResource {
    
    private let moodButtonTitle: [String] = [
        "기뻐요",
        "즐거워요",
        "행복해요",
        "지쳤어요",
        "우울해요",
        "힘들어요",
        "화나요",
        "스트레스받아요",
        "긴장돼요",
        "걱정돼요",
        "기대돼요",
    ]

    func moodButtonTitleArray() -> [String] {
        return moodButtonTitle
    }
}
