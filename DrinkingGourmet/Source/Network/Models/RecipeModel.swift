//
//  RecipeModel.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 8/11/24.
//

import Foundation

struct RecipeModel {
    let id: Int
    let name: String
    let cookingTime: String
    let ingredient: String
    let imageUrl: String?
}

extension RecipeDTO {
    func toModel() -> RecipeModel {
        return RecipeModel(
            id: id,
            name: recipeName,
            cookingTime: cookingTime,
            ingredient: ingredient,
            imageUrl: recipeImageUrl
        )
    }
}
