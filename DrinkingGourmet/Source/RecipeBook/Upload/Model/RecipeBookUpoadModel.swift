//
//  RecipeBookUpoadModel.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/20/24.
//

struct RecipeBookUpoadModel {
    struct ImageUploadRequest: Codable {
        let file: [ImageUrl]
        
        struct ImageUrl: Codable {
            let imageUrl: String
        }
    }
    
    // MARK: - ImageResponseModel
    struct ImageUploadResponse: Codable {
        let isSuccess: Bool
        let code, message: String
        let result: Result
    }
    
    // MARK: - Result
    struct Result: Codable {
        let imageURLList: [String]

        enum CodingKeys: String, CodingKey {
            case imageURLList = "imageUrlList"
        }
    }
    
    
    
    struct RecipeRequest: Codable {
        let title, cookingTime, calorie, ingredient: String
        let recipeInstruction, recommendCombination: String
        let hashTagNameList: [String]
    }
    
    struct RecipeResponseModel: Codable {
        let isSuccess: Bool
        let code: String
        let message: String
        let result: Results
    }

    struct Results: Codable {
        let id: Int
        let title, cookingTime, calorie: String
        let likeCount, commentCount: Int
        let ingredient, recipeInstruction, recommendCombination: String
        let state: Bool
        let member: MemberModel
        let recipeImageList: [String]
        let hashTagNameList: [String]
        let like: Bool
    }

    struct MemberModel: Codable {
        let memberId: Int
        let nickName, profileImageUrl: String
    }

    
}
