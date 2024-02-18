//
//  CombinationCommentModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

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
        let content, memberNickName: String
        let memberProfile: String?
        let createdAt: String
        let childCount: Int
        let childComments: [CombinationCommentList]
    }
}
