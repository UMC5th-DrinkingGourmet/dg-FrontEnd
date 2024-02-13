//
//  RecipeBookHomeInput.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

// MARK: - 레시피북 홈 조회 Query Prams
struct RecipeBookHomeInput: Codable {
    var page: Int?
}

// MARK: - 레시피북 검색 후 목록 가져오기 Query Prams
struct RecipeBookSearchInput: Codable {
    var page: Int?
    var keyword: String?
}
