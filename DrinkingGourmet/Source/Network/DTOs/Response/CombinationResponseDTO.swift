//
//  c.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 8/11/24.
//

import Foundation

struct CombinationResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CombinationListResultDTO
}

struct CombinationListResultDTO: Decodable {
    let combinationList: [CombinationDTO]
}

struct CombinationDTO: Decodable {
    let combinationId: Int
    let title: String
    let combinationImageUrl: String
    let hashTagList: [String]?
}

extension CombinationDTO {
    func toModel() -> CombinationModel {
        let hashtags = hashTagList?.joined(separator: " ") ?? ""
        print("Transformed hashtags: \(hashtags)") // 변환된 해시태그 문자열을 출력하여 확인
        return CombinationModel(
            id: combinationId,
            title: title,
            imageUrl: combinationImageUrl,
            hashTags: hashtags
        )
    }
}
