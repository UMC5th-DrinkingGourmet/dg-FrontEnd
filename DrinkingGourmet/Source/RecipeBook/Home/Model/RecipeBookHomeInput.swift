//
//  RecipeBookHomeInput.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

struct RecipeBookHomeInput {
    
    struct fetchRecipeBookHomeDataInput: Codable {
        var page: Int?
    }
    
    struct fetchRecipeBookDataForSearchInput: Codable {
        var page: Int?
        var keyword: String?
    }
    
}
