//
//  RecipeBookDetailModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

struct RecipeBookDetailModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    struct Result: Codable {
        let id: Int
        let title, cookingTime, calorie: String
        let likeCount, commentCount: Int
        let ingredient, recipeInstruction, recommendCombination: String
        let state: Bool
        let memberNickName: String
        let recipeImageList: [String]
        let hashTagNameList: [String]
        let like: Bool
    }
}

