//
//  CombinationCommentInput.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

struct CombinationCommentInput {
    
    struct fetchCombinatiCommentDataInput: Codable {
        let page: Int?
    }
    
    struct postCommentInput: Codable {
        let content: String
        let parentId: String
    }
}
