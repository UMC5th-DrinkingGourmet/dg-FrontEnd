//
//  CombinationDetailModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

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
        let content: String
        let memberId: Int
        let memberNickName: String
        let memberProfile: String?
        let createdAt: String
        let childCount: Int
        let childComments: [CombinationCommentList]
        let state: String
    }
    
    struct CombinationResult: Codable {
        let combinationId: Int
        let title, content: String
        let hashTagList: [String]
        let combinationImageList: [String]
        let isCombinationLike: Bool
    }
    
    struct MemberResult: Codable {
        let memberId: Int
        let nickName: String
        let profileImageUrl: String?
    }
}
