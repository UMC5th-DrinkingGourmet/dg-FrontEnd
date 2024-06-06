//
//  RecipeBookDTO.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 6/6/24.
//

// MARK: - 레시피북 홈
struct RecipeBookHomeResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RecipeBookHomeResultDTO
}

struct RecipeBookHomeResultDTO: Codable {
    let recipeList: [RecipeBookHomeDTO]
    let listSize: Int
    let totalPage: Int
    let totalElements: Int
    let isFirst: Bool
    let isLast: Bool
}

struct RecipeBookHomeDTO: Codable {
    let id: Int
    let title: String
    let cookingTime: String
    let calorie: String
    let likeCount: Int
    let commentCount: Int
    let ingredient: String
    let recipeInstruction: String
    let recommendCombination: String
    let state: Bool
    let member: RecipeBookMemberDTO
    let recipeImageList: [String]
    let hashTagNameList: [String]
    var like: Bool
}

struct RecipeBookMemberDTO: Codable {
    let memberId: Int
    let nickName: String
    let profileImageUrl: String?
}

// MARK: - 레시피북 상세
struct RecipeBookDetailResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: RecipeBookHomeDTO
}

// MARK: - 레시피북 댓글
struct RecipeBookCommentResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: RecipeBookCommentResultDTO
}

struct RecipeBookCommentResultDTO: Codable {
    let commentList: [RecipeBookCommentDTO]
    let listSize, totalPage, totalElements: Int
    let isFirst, isLast: Bool
}

struct RecipeBookCommentDTO: Codable {
    let id: Int
    let content: String
    let member: RecipeBookMemberDTO
    let createdDate, updatedDate: String
    let childCommentList: [RecipeBookCommentDTO]
    let childCommentCount: Int
    let state: String
}
