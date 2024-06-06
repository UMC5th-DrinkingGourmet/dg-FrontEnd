//
//  CombinationDto.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 6/4/24.
//

// MARK: - 오늘의 조합 홈
struct CombinationHomeResponseDto: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CombinationHomeResultDto
}

struct CombinationHomeResultDto: Codable {
    let combinationList: [CombinationHomeDto]
    let listSize: Int
    let totalPage: Int
    let totalElements: Int
    let isFirst: Bool
    let isLast: Bool
}

struct CombinationHomeDto: Codable {
    let combinationId: Int
    let title: String
    let combinationImageUrl: String
    let likeCount: Int
    let commentCount: Int
    let hashTageList: [String]
    var isLike: Bool
}

// MARK: - 오늘의 조합 상세
struct CombinationDetailResponseDto: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CombinationDetailResultDto
}

struct CombinationDetailResultDto: Codable {
    let combinationResult: CombinationDetailDto
    let memberResult: CombinationMemberDto
    let combinationCommentResult: CombinationCommentResultDto
}

struct CombinationDetailDto: Codable {
    let combinationId: Int
    let title: String
    let content: String
    let hashTagList: [String]
    let combinationImageList: [String]
    let isCombinationLike: Bool
}

struct CombinationMemberDto: Codable {
    let memberId: Int
    let nickName: String
    let profileImageUrl: String?
}

struct CombinationCommentResultDto: Codable {
    let combinationCommentList: [CombinationCommentDto]
    let listSize:Int
    let totalPage: Int
    let totalElements: Int
    let isFirst: Bool
    let isLast: Bool
}

struct CombinationCommentDto: Codable {
    let id: Int
    let content: String
    let memberId: Int
    let memberNickName: String
    let memberProfile: String?
    let createdAt: String
    let childCount: Int
    let childComments: [CombinationCommentDto]
    let state: String
}

// MARK: - 오늘의 조합 댓글
struct CombinationCommentResponseDto: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: CombinationCommentResultDto
}
