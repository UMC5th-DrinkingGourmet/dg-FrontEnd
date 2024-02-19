//
//  CombinationUploadModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/16/24.
//

struct CombinationUploadModel {
    
    struct fetchRecommendListModel: Codable {
        let isSuccess: Bool
        let code, message: String
        let result: Result
        
        struct Result: Codable {
            let recommendResponseDTOList: [RecommendResponseDTOList]
            let listSize, totalPage, totalElements: Int
            let isFirst, isLast: Bool
        }
        
        struct RecommendResponseDTOList: Codable {
            let foodName, drinkName, recommendReason: String
            let imageUrl: String
        }
    }
    
    struct imageUploadRequest: Codable {
        let imageUrls: [ImageUrl]
        
        struct ImageUrl: Codable {
            let imageUrl: String
        }
    }
    
    struct imageUploadResponse: Codable {
        let isSuccess: Bool
        let code: String
        let message: String
        let result: ResultData? 

        struct ResultData: Codable {
            let combinationImageList: [String]?
        }
    }

    
    
}
