//
//  RecipeBookCommentModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/19/24.
//

struct RecipeBookCommentModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    struct Result: Codable {
        let commentList: [CommentList]
        let listSize, totalPage, totalElements: Int
        let isFirst, isLast: Bool
    }
    
    struct CommentList: Codable {
        let id: Int
        let content: String
        let member: Member
        let createdDate, updatedDate: String
        let childCommentList: [CommentList]
        let childCommentCount: Int
    }
    
    struct Member: Codable {
        let memberId: Int
        let nickName: String
        let profileImageUrl: String?
    }
}
