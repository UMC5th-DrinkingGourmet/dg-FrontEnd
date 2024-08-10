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
    let hashTagList: [String]
}
