//
//  RecipeBookDetailImageModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

// MARK: - 레시피북 상세정보 이미지 조회
struct RecipeBookDetailImageModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: [String]
}
