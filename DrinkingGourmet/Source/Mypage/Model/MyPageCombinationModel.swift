//
//  MyPageCombinationModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

struct MyPageCombinationModel: Codable {
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

