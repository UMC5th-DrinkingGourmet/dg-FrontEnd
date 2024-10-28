//
//  MainRecipeBookDTO.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 8/11/24.
//

import Foundation

struct RecipeResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RecipeListResultDTO
}

struct RecipeListResultDTO: Decodable {
    let recipeList: [RecipeDTO]
}

struct RecipeDTO: Decodable {
    let id: Int
    let recipeName: String
    let cookingTime: String
    let ingredient: String
    let recipeImageUrl: String?
}


