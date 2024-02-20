//
//  MyRecommendInput.swift
//  DrinkingGourmet
//
//  Created by hee on 2/20/24.
//

import Alamofire

class myDrinkingStyleParameters: Codable{
    static let shared = myDrinkingStyleParameters()
    
    var preferredAlcoholType: String?
    var preferredAlcoholDegree: String?
    var drinkingLimit: String?
    var drinkingTimes: String?
    
    private init() { }
}

struct MyDrinkingStyleResponse: Codable{
    let isSuccess: Bool
    let code: String
    let message: String
    let result: Result
}

struct Result: Codable {
    let preferredAlcoholType: String
    let preferredAlcoholDegree: String
    let drinkingLimit: String
    let drinkingTimes: String
}
