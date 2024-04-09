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
        let title, cookingTime, calorie: String
        let likeCount, commentCount: Int
        let ingredient, recipeInstruction, recommendCombination: String
        let state: Bool
        let member: Member
        let recipeImageList: [String]
        let hashTagNameList: [String]
        var like: Bool
    }
    
    struct Member: Codable {
        let memberId: Int
        let nickName: String
        let profileImageUrl: String?
    }
}
