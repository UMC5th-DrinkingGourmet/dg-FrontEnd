//
//  RecipeBookHomeDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import Alamofire

class RecipeBookHomeDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 레시피북 홈 조회
    func fetchRecipeBookHomeData(_ parameters: RecipeBookHomeInput.fetchRecipeBookHomeDataInput,
                                  _ viewController: RecipeBookHomeVC,
                                  completion: @escaping (RecipeBookHomeModel?) -> Void) {
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/recipes",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: RecipeBookHomeModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("레시피북 홈 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("레시피북 홈 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 레시피북 검색
    func fetchRecipeBookDataForSearch(_ parameters: RecipeBookHomeInput.fetchRecipeBookDataForSearchInput,
                                       _ viewController: RecipeBookHomeVC,
                                       completion: @escaping (RecipeBookHomeModel?) -> Void) {
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/recipes/search",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: RecipeBookHomeModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("레시피북 검색 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("레시피북 검색 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
}
