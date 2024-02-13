//
//  RecipeBookHomeDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import Alamofire

class RecipeBookHomeDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    private let testAccessToken: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJrYWthb18xMjM0NTY3ODkiLCJpYXQiOjE3MDc4MTY0OTQsImV4cCI6MTcwODQyMTI5NH0.tL3VWPK1W_3IR3_eIyOS0Lmn1qNTnfKRcb-nkNU7Glo"
    ]
    
    // MARK: - 레시피북 홈 조회
    func fetchRecipeBookHomeData(_ parameters: RecipeBookHomeInput,
                                  _ viewController: RecipeBookHomeVC,
                                  completion: @escaping (RecipeBookHomeModel?) -> Void) {
        
        // Alamofire 요청
        AF.request("\(baseURL)/recipes",
                   method: .get,
                   parameters: parameters,
                   headers: testAccessToken)
        .validate()
        .responseDecodable(of: RecipeBookHomeModel.self) { response in
            switch response.result {
            case .success(let result):
                print("레시피북 홈 - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("레시피북 홈 - \(error)")
                completion(nil)
            }
        }
    }
}
