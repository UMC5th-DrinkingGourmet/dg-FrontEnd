//
//  MyPageInput.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

struct MyPageInput {
    struct fetchRecommendListDataInput: Codable {
        var page: Int?
        var size: Int?
    }
    
    struct fetchCombinationDataInput: Codable {
        var page: Int?
    }
    
    struct fetchRecipeBookDataInput: Codable {
        var page: Int?
    }
}
