//
//  MyRecommendInput.swift
//  DrinkingGourmet
//
//  Created by hee on 2/19/24.
//
import Alamofire

class recommendsRequestParameters: Codable {
    static let shared = recommendsRequestParameters()
     
    var desireLevel: Int = 0
    var foodName: String = ""
    var feeling: String = ""
    var weather: String = ""
    
    private init() {
        
    }
}
