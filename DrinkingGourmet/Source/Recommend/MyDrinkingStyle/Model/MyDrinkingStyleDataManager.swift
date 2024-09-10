//
//  MyDrinkingStyleDataManager.swift
//  DrinkingGourmet
//
//  Created by hee on 2/20/24.
//

import Alamofire

class MyDrinkingStyleDataManager {
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    func patchMyDrinkingStyleData(_ parameters: myDrinkingStyleParameters, completion: @escaping (Swift.Result<MyDrinkingStyleResponse, AFError>) -> Void) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/users/recommend-info",
                       method: .patch,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default,
                       headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MyDrinkingStyleResponse.self) { response in
                switch response.result {
                case .success(let myDrinkingStyleResponse):
                    debugPrint(myDrinkingStyleResponse.result)
                    completion(.success(myDrinkingStyleResponse))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            print("Failed to get access token")
            completion(.failure(AFError.invalidURL(url: "\(baseURL)/users/recommend-info")))
        }
    }
}
