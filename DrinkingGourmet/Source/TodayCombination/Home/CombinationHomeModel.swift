//
//  CombinationHomeModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/10/24.
//

import Foundation

// MARK: - CombinationHomeModel
struct CombinationHomeModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: CombinationHomeModelResult
}

// MARK: - CombinationHomeModelResult
struct CombinationHomeModelResult: Codable {
    let combinationList: [CombinationHomeList]
    let listSize, totalPage, totalElements: Int
    let isFirst, isLast: Bool
}

// MARK: - CombinationHomeList
struct CombinationHomeList: Codable {
    let title: String
    let combinationImageURL: String
    let likeCount, commentCount: Int
    let hashTageList: [String]

    enum CodingKeys: String, CodingKey {
        case title
        case combinationImageURL = "combinationImageUrl"
        case likeCount, commentCount, hashTageList
    }
}
