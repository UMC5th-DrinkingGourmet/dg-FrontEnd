//
//  MyPageRecipeBookModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

struct MyPageRecipeBookModel: Codable {
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
