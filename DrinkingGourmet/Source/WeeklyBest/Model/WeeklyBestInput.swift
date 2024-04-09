//
//  WeeklyBestInput.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

// MARK: - 주간 베스트 조합 조회 Query Params
struct fetchWeeklyBestDataInput: Codable {
    var page: Int?
}

// MARK: - 주간 베스트 조합 검색 Query Params
struct fetchweeklyBestDataForSearchInput: Codable {
    var page: Int?
    var keyword: String?
}
