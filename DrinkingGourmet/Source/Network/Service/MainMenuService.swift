//
//  MainMenuService.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 8/11/24.
//

// MainMenuService.swift
import UIKit
import Alamofire

final class MainMenuService {
    
    static let shared = MainMenuService()
    
    private init() {}
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    private let interceptor = AuthInterceptor()
    
    func fetchRecipes(completionHandler: @escaping ([RecipeModel]) -> Void) {
        guard let accessToken = try? Keychain.shared.getToken(kind: .accessToken),
              let refreshToken = try? Keychain.shared.getToken(kind: .refreshToken) else {
            print("Token not found")
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "RefreshToken": refreshToken,
            "Content-Type": "application/json"
        ]
        
        let url = "\(baseURL)/recipes/main"
        
        AF.request(url,
                   method: .get,
                   headers: headers,
                   interceptor: interceptor
        ).responseDecodable(of: RecipeResponseDTO.self) { response in
            switch response.result {
            case .success(let recipeResponse):
                if recipeResponse.isSuccess {
                    let models = recipeResponse.result.recipeList.map { $0.toModel() }
                    completionHandler(models)
                } else {
                    print("API Error: \(recipeResponse.message)")
                }
            case .failure(let error):
                print("Failed to fetch recipes: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchWeeklyBestCombinations(completionHandler: @escaping ([CombinationModel]) -> Void) {
        let url = "\(baseURL)/combinations/main/rotation"
        
        AF.request(url, method: .get, interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: CombinationResponseDTO.self) { response in
                switch response.result {
                case .success(let combinationResponse):
                    if combinationResponse.isSuccess {
                        let models = combinationResponse.result.combinationList.map { $0.toModel() }
                        completionHandler(models)
                    } else {
                        print("API Error: \(combinationResponse.message)")
                    }
                case .failure(let error):
                    print("Failed to fetch combinations: \(error.localizedDescription)")
                }
            }
    }

}
