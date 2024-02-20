//
//  MyRecommendModel.swift
//  DrinkingGourmet
//
//  Created by hee on 2/19/24.
//

import Alamofire

class MyRecommendModelManager {
    static let shared = MyRecommendModelManager()
    
    private init() {}
    
    var model: MyRecommendModel?
    var netWorkDuration: Double?
}

struct MyRecommendModel: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: RecommendResult?
}

struct RecommendResult: Codable {
    let recommendID: Int
    let foodName: String
    let drinkName: String
    let recommendReason: String
    let imageUrl: String
}

//class MyRecommendResults: Decodable {
//    static let shared = MyRecommendResults()
//    
//    var isSuccess: Bool
//    var code: String
//    var message: String
//    var result: RecommendResult?
//    
//    struct RecommendResult: Decodable {
//        let recommendID: Int
//        let foodName: String
//        let drinkName: String
//        let recommendReason: String
//        let imageUrl: String
//        
//        private init() {}
//    }
//}



//struct MyRecommendModel: Codable {
//    let isSuccess: Bool
//    let code: String
//    let message: String
//    let result: RecommendResult?
//}
//
//struct RecommendResult: Codable {
//    let recommendID: Int
//    let foodName: String
//    let drinkName: String
//    let recommendReason: String
//    let imageUrl: String
//}
