//
//  CombinationCommentInput.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

struct CombinationCommentInput {
    
    struct postCommentInput: Codable {
        let content: String
        let parentId: String
    }
}
