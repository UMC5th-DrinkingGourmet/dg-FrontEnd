//
//  RecipeBookHomeModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

struct RecipeBookHomeModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    struct Result: Codable {
        let recipeList: [RecipeList]
        let listSize, totalPage, totalElements: Int
        let isFirst, isLast: Bool
    }
    
    struct RecipeList: Codable {
        let id: Int
        let name, info, cookingTime, calorie: String
        let likeCount, commentCount: Int
        let ingredient, recipeInstruction, recommendCombination: String
        let state: Bool
        let memberNickName: String
        let recipeImageList: [String]
        let hashTagNameList: [String]
    }
}
