//
//  CombinationCommentModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

// MARK: - 오늘의 조합 상세보기 댓글 페이징 조회 Model
struct CombinationCommentModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    struct Result: Codable {
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
}
