//
//  LikeAllRecipeBookModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

struct LikeAllRecipeBookModel: Codable {
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
        let name: String
        let recipeImageUrl: String
    }
}
