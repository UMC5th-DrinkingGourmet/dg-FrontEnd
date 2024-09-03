//
//  RecipeBookUploadDTO.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 7/1/24.
//

import Foundation

struct RecipeBookUploadModel {
    struct ImageUploadRequestDTO: Codable {
        let imageUrls: [ImageUrl]
        
        struct ImageUrl: Codable {
            let imageUrl: String
        }
    }
    
    struct ImageUploadResponseDTO: Codable {
        let isSuccess: Bool?
        let code, message: String?
        let result: ResultData?
        
        struct ResultData: Codable {
            let recipeImageList: [String]?
        }
    }

//    struct ResultDTO: Codable {
//        let imageURLList: [String]?
//
//        enum CodingKeys: String, CodingKey {
//            case imageURLList = "imageUrlList"
//        }
//    }
    
    struct RecipeRequestDTO: Codable {
        let title, cookingTime, calorie, ingredient: String
        let recipeInstruction, recommendCombination: String
        let hashTagNameList, recipeImageList: [String]
    }
    
    struct RecipeResponseDTO: Codable {
        let isSuccess: Bool
        let code: String
        let message: String
        let result: ResultsDTO
    }

    struct ResultsDTO: Codable {
        let id: Int?
        let title, cookingTime, calorie: String
        let likeCount, commentCount: Int
        let ingredient, recipeInstruction, recommendCombination: String
        let state: Bool
        let member: MemberDTO
        let recipeImageList: [String]
        let hashTagNameList: [String]
        let like: Bool
    }

    struct MemberDTO: Codable {
        let memberId: Int
        let nickName, profileImageUrl: String
    }
}
