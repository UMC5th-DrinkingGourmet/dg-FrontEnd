//
//  MyPageRecommendModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

struct MyPageRecommendModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    struct Result: Codable {
        let recommendResponseDTOList: [RecommendResponseDTOList]
        let listSize, totalPage, totalElements: Int
        let isFirst, isLast: Bool
    }
    
    struct RecommendResponseDTOList: Codable {
        let recommendID: Int
        let foodName, drinkName, recommendReason: String
        let imageUrl: String
    }
    
}
