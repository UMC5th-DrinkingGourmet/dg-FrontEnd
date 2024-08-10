//
//  CombinationModel.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 8/11/24.
//

import Foundation

struct CombinationModel {
    let id: Int
    let title: String
    let imageUrl: String
    let hashTags: String
}

extension CombinationDTO {
    func toModel() -> CombinationModel {
        return CombinationModel(
            id: combinationId,
            title: title,
            imageUrl: combinationImageUrl,
            hashTags: hashTagList.joined(separator: " ")
        )
    }
}
