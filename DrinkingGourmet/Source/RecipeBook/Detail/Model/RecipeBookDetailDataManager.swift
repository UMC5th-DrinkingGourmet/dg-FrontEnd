//
//  RecipeBookDetailDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import Alamofire

class RecipeBookDetailDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    private let testAccessToken: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJrYWthb18xMjM0NTY3ODkiLCJpYXQiOjE3MDc4MTY0OTQsImV4cCI6MTcwODQyMTI5NH0.tL3VWPK1W_3IR3_eIyOS0Lmn1qNTnfKRcb-nkNU7Glo"
    ]
    
    // MARK: - 레시피북 상세정보 조회
    func fetchRecipeBookDetailData(_ recipeBookId: Int, _ viewController: RecipeBookDetailVC, completion: @escaping (RecipeBookDetailModel?) -> Void) {
        
        AF.request("\(baseURL)/recipes/\(recipeBookId)", method: .get, headers: testAccessToken).validate().responseDecodable(of: RecipeBookDetailModel.self) { response in
            switch response.result {
            case .success(let result):
                print("레시피북 상세정보 조회 - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("레시피북 상세정보 조회 - \(error)")
                completion(nil)
            }
        }
    }
    
    // MARK: - 레시피북 상세정보 이미지 조회
    func fetchRecipeBookDetailImageData(_ parameters: RecipeBookDetailImageInput,
                                       _ viewController: RecipeBookDetailVC,
                                       completion: @escaping (RecipeBookDetailImageModel?) -> Void) {
        
        AF.request("\(baseURL)/recipe-images",
                   method: .get,
                   parameters: parameters,
                   headers: testAccessToken)
        .validate()
        .responseDecodable(of: RecipeBookDetailImageModel.self) { response in
            switch response.result {
            case .success(let result):
                print("레시피북 상세정보 이미지 조회 - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("레시피북 상세정보 이미지 조회 - \(error)")
                completion(nil)
            }
        }
    }
}
