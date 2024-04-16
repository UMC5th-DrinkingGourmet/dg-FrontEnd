//
//  RecipeBookCommentInput.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/19/24.
//

struct RecipeBookCommentInput {
    
    struct fetchRecipeBookCommentDataInput: Codable {
        let page: Int?
    }
    
    struct postCommentInput: Codable {
        let content: String
        let parentId: String
    }
    
    struct deleteCommentInput: Codable {
        let recipeCommentId: Int
    }
    
}
