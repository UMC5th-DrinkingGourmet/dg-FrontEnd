//
//  RecipeBookDetailDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import Alamofire

class RecipeBookDetailDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 레시피북 상세정보 조회
    func fetchRecipeBookDetailData(_ recipeBookId: Int, _ viewController: RecipeBookDetailVC, completion: @escaping (RecipeBookDetailModel?) -> Void) {
        
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/recipes/\(recipeBookId)",
                       method: .get,
                       headers: headers)
            .validate()
            .responseDecodable(of: RecipeBookDetailModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("레시피북 상세정보 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("레시피북 상세정보 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
}
