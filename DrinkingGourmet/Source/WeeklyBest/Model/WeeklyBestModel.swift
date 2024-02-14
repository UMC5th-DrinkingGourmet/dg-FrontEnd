//
//  WeeklyBestModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

// MARK: - 주간 베스트 조합 조회 Model
struct WeeklyBestModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    struct Result: Codable {
        let combinationList: [CombinationList]
        let listSize, totalPage, totalElements: Int
        let isFirst, isLast: Bool
    }

    struct CombinationList: Codable {
        let combinationId: Int
        let title: String
        let combinationImageUrl: String
        let likeCount, commentCount: Int
        let hashTageList: [String]
        let isLike: Bool
    }
}
