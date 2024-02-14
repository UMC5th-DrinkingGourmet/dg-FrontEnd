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
    
    struct CombinationHomeModelResult: Codable {
        let combinationList: [CombinationHomeList]
        let listSize, totalPage, totalElements: Int
        let isFirst, isLast: Bool
    }

    struct CombinationHomeList: Codable {
        let combinationId: Int
        let title: String
        let combinationImageUrl: String
        let likeCount, commentCount: Int
        let hashTageList: [String]
    }
}
