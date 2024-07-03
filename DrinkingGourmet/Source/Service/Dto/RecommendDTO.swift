//
//  RecommendDTO.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

// MARK: - 주류추천 요청
class RecommendRequestDTO: Codable {
    static let shared = RecommendRequestDTO()
    private init() {}
    
    var desireLevel: Int = 0
    var foodName: String = ""
    var mood: String = ""
    var weather: String = ""
}

struct RecommendResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: RecommendResultDTO
}

struct RecommendResultDTO: Codable {
    let recommendID: Int
    let foodName, drinkName, recommendReason, imageUrl: String
}
