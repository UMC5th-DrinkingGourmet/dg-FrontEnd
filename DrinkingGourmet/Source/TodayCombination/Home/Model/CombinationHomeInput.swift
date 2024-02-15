//
//  CombinationHomeInput.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/10/24.
//

struct CombinationHomeInput {
    
    struct fetchCombinationHomeDataInput: Codable {
        var page: Int?
    }
    
    struct fetchCombinationSearchDataInput: Codable {
        var page: Int?
        var keyword: String?
    }
    
}
