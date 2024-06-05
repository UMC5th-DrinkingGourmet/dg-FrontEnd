//
//  CombinationDto.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 6/4/24.
//

struct CombinationHomeResponseDto: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CombinationHomeResultDto
}

struct CombinationHomeResultDto: Codable {
    let combinationList: [CombinationHomeDto]
    let listSize, totalPage, totalElements: Int
    let isFirst, isLast: Bool
}

struct CombinationHomeDto: Codable {
    let combinationId: Int
    let title: String
    let combinationImageUrl: String?
    let likeCount, commentCount: Int
    let hashTageList: [String]
    var isLike: Bool
}
