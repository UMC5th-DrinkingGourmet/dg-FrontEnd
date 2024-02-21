//
//  RecommendDetailResponseModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/21/24.
//

struct RecommendDetailResponseModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    struct Result: Codable {
        let recommendID: Int
        let foodName, drinkName, recommendReason: String
        let imageUrl: String
    }
}
