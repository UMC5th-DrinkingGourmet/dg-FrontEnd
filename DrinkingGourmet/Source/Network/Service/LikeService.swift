//
//  LikeService.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 6/9/24.
//

import Alamofire

final class LikeService {
    
    static let shared = LikeService()
    private init() {}
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    private func getHeaders() throws -> HTTPHeaders {
        let accessToken = try Keychain.shared.getToken(kind: .accessToken)
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    // MARK: - 좋아요한 오늘의 조합 페이징 조회
    func getCombination(page: Int,
                        completion: @escaping (Swift.Result<LikeCombinationResponseDTO, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String : Any] = [
                "page" : page
            ]
            
            AF.request("\(baseURL)/combinations/likes",
                       method: .get,
                       parameters: parameters,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .responseDecodable(of: LikeCombinationResponseDTO.self) { response in
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
    
    // MARK: - 좋아요한 레시피북 페이징 조회
    func getRecipeBook(page: Int,
                       completion: @escaping (Swift.Result<LikeRecipeBookResponseDTO, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String : Any] = [
                "page" : page
            ]
            
            AF.request("\(baseURL)/recipes/likes",
                       method: .get,
                       parameters: parameters,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .responseDecodable(of: LikeRecipeBookResponseDTO.self) { response in
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
