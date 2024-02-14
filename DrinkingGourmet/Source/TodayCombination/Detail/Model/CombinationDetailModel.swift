//
//  CombinationDetailModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

// MARK: - 오늘의 조합 상세보기 조회 Model
struct CombinationDetailModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    struct Result: Codable {
        let combinationResult: CombinationResult
        let memberResult: MemberResult
        let combinationCommentResult: CombinationCommentResult
    }

    struct CombinationCommentResult: Codable {
        let combinationCommentList: [CombinationCommentList]
        let listSize, totalPage, totalElements: Int
        let isFirst, isLast: Bool
    }

    struct CombinationCommentList: Codable {
        let id: Int
        let content, memberName, updatedAt: String
        let childCount: Int
        let childComments: [CombinationCommentList]
    }

    struct CombinationResult: Codable {
        let combinationID: Int
        let title, content: String
        let hashTagList: [String]
        let combinationImageList: [String]
        let isCombinationLike: Bool

        enum CodingKeys: String, CodingKey {
            case combinationID = "combinationId"
            case title, content, hashTagList, combinationImageList, isCombinationLike
        }
    }

    struct MemberResult: Codable {
        let memberID: Int
        let name, profileImageURL: String?

        enum CodingKeys: String, CodingKey {
            case memberID = "memberId"
            case name
            case profileImageURL = "profileImageUrl"
        }
    }
}
