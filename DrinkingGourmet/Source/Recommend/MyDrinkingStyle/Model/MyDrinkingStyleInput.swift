//
//  MyRecommendInput.swift
//  DrinkingGourmet
//
//  Created by hee on 2/20/24.
//

import Alamofire

struct MyRecommendParameters: Codable{
    static let shared = MyRecommendParameters()
    
    var preferredAlcoholType: String
    var preferredAlcoholDegree: String
    var drinkingLimit: String
    var drinkingTimes: String
    
    private init() {
        
    }

}
