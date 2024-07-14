//
//  AuthService.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 7/1/24.
//

import UIKit
import Alamofire

final class AuthService {
    static let shared = AuthService()
    private init() {}
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    func refreshToken(completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        do {
            let refreshToken = try Keychain.shared.getToken(kind: .refreshToken)
            
            let parameters: [String: Any] = ["refreshToken": refreshToken]
            
            AF.request("\(baseURL)/auth/refresh",
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default)
                .validate()
                .responseDecodable(of: RefreshTokenResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        do {
                            try Keychain.shared.saveToken(kind: .accessToken, token: result.accessToken)
                            completion(.success(()))
                        } catch {
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        } catch {
            completion(.failure(error))
        }
    }
    
    enum AuthError: Error {
        case noRefreshToken
    }
    
    struct RefreshTokenResponse: Codable {
        let accessToken: String
    }
}
