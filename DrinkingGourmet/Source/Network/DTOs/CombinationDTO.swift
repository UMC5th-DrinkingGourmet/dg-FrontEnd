//
//  CombinationDTO.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 6/4/24.
//

// MARK: - 오늘의 조합 홈
struct CombinationHomeResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CombinationHomeResultDTO
}

struct CombinationHomeResultDTO: Codable {
    let combinationList: [CombinationHomeDTO]
    let listSize: Int
    let totalPage: Int
    let totalElements: Int
    let isFirst: Bool
    let isLast: Bool
}

struct CombinationHomeDTO: Codable {
    let combinationId: Int
    let title: String
    let combinationImageUrl: String?
    let likeCount: Int
    let commentCount: Int
    let hashTageList: [String]
    var isLike: Bool
}

// MARK: - 오늘의 조합 상세
struct CombinationDetailResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CombinationDetailResultDTO
}

struct CombinationDetailResultDTO: Codable {
    let combinationResult: CombinationDetailDTO
    let memberResult: CombinationMemberDTO
    let combinationCommentResult: CombinationCommentResultDTO
}

struct CombinationDetailDTO: Codable {
    let combinationId: Int
    let title: String
    let content: String
    let hashTagList: [String]
    let combinationImageList: [String]
    let isCombinationLike: Bool
    let recommendId: Int
    let recommend: String
}

struct CombinationMemberDTO: Codable {
    let memberId: Int
    let nickName: String
    let profileImageUrl: String?
}

struct CombinationCommentResultDTO: Codable {
    let combinationCommentList: [CombinationCommentDTO]
    let listSize:Int
    let totalPage: Int
    let totalElements: Int
    let isFirst: Bool
    let isLast: Bool
}

struct CombinationCommentDTO: Codable {
    let id: Int
    let content: String
    let memberId: Int
    let memberNickName: String
    let memberProfile: String?
    let createdAt: String
    let childCount: Int
    let childComments: [CombinationCommentDTO]
    let state: String
}

// MARK: - 오늘의 조합 댓글
struct CombinationCommentResponseDTO: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: CombinationCommentResultDTO
}
