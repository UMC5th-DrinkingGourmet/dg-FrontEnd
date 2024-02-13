//
//  RecipeBookDetailModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

// MARK: - 레시피북 상세정보 조회 Model
struct RecipeBookDetailModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    // MARK: - Result
    struct Result: Codable {
        let id: Int
        let name, info, cookingTime, calorie: String
        let likeCount, commentCount: Int
        let ingredient, recipeInstruction, recommendCombination: String
        let state: Bool
        let memberName: String
    }
}
