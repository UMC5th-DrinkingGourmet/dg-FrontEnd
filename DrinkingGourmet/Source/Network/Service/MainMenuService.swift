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
                   headers: headers).responseDecodable(of: RecipeResponseDTO.self) { response in
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
}
