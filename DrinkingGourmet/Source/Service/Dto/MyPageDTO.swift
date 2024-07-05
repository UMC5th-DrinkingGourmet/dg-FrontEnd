//
//  MyPageDTO.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/5/24.
//

// MARK: - 내 정보
struct MyInfoResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: MyInfoResultDTO
}

struct MyInfoResultDTO: Codable {
    let memberId: Int
    let name, nickName, gender, birthDate, profileImageUrl, phoneNumber, provider: String
}

// MARK: - 나의 주류 추천
struct MyRecommendResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: MyRecommendResultDTO
}

struct MyRecommendResultDTO: Codable {
    let recommendResponseDTOList: [RecommendResultDTO]
    let listSize, totalPage, totalElements: Int
    let isFirst, isLast: Bool
}

// MARK: - 나의 오늘의 조합
struct MyCombinationResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
}

struct MyCombinationResultDTO: Codable {
    let combinationList: [MyCombinationDTO]
    let listSize, totalPage, totalElements: Int
    let isFirst, isLast: Bool
}

struct MyCombinationDTO: Codable {
    let combinationId: Int
    let title: String
    let combinationImageUrl: String
}

// MARK: - 나의 레시피북
struct MyRecipeBookResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
}

struct MyRecipeBookResultDTO: Codable {
    let recipeList: [MyRecipeBookDTO]
    let listSize, totalPage, totalElements: Int
    let isFirst, isLast: Bool
}

struct MyRecipeBookDTO: Codable {
    let id: Int
    let name: String
    let recipeImageUrl: String
}
