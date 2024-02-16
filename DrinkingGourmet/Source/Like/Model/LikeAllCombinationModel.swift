//
//  LikeAllCombinationModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

struct LikeAllCombinationModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    struct Result: Codable {
        let combinationList: [CombinationList]
        let listSize, totalPage, totalElements: Int
        let isFirst, isLast: Bool
    }
    
    struct CombinationList: Codable {
        let combinationId: Int
        let title: String
        let combinationImageUrl: String
    }
}


