//
//  RecommendService.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/4/24.
//

import Alamofire

final class RecommendService {
    
    static let shared = RecommendService()
    private init() {}
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    private func getHeaders() throws -> HTTPHeaders {
        let accessToken = try Keychain.shared.getToken(kind: .accessToken)
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    // MARK: - 주류추천 요청
    func postRecommend(request: RecommendRequestDTO,
                       completion: @escaping (Swift.Result<RecommendResponseDTO, Error>) -> Void) {
        
        do {
            let headers = try getHeaders()
            
            let parameters: [String: Any] = [
                "desireLevel": request.desireLevel,
                "foodName": request.foodName,
                "mood": request.mood,
                "weather": request.weather
            ]
            
            print(parameters)
            
            AF.request("\(baseURL)/recommends/request",
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
            .validate()
            .responseDecodable(of: RecommendResponseDTO.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
}
