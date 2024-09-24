//
//  TermsRequestDTO.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 9/24/24.
//

import Foundation

class TermsRequestDTO {
    static let shared = TermsRequestDTO()
    
    private init() { }
    
    var termList: [String] = []
}
