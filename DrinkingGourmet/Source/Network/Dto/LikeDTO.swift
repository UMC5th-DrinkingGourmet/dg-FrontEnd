//
//  LikeDTO.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 6/9/24.
//

// MARK: - 좋아요한 오늘의 조합
struct LikeCombinationResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: LikeCombinationResultDTO
}

struct LikeCombinationResultDTO: Codable {
    let combinationList: [LikeCombinationDTO]
    let listSize, totalPage, totalElements: Int
    let isFirst, isLast: Bool
}

struct LikeCombinationDTO: Codable {
    let combinationId: Int
    let title: String
    let combinationImageUrl: String
}

// MARK: - 좋아요한 레시피북
struct LikeRecipeBookResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: LikeRecipeBookResultDTO
}

struct LikeRecipeBookResultDTO: Codable {
    let recipeList: [LikeRecipeBookDTO]
    let listSize, totalPage, totalElements: Int
    let isFirst, isLast: Bool
}

struct LikeRecipeBookDTO: Codable {
    let id: Int
    let name: String
    let recipeImageUrl: String
}
