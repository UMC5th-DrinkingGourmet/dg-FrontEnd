//
//  AuthService.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 7/1/24.
//

import Foundation
import Alamofire

class AuthInterceptor: RequestInterceptor {
    private let keychain = Keychain.shared
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Swift.Result<URLRequest, Error>) -> Void) {
        do {
            var urlRequest = urlRequest
            let accessToken = try keychain.getToken(kind: .accessToken)
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            completion(.success(urlRequest))
            print("interceptor success")
        } catch {
            print("interceptor failed")
            completion(.failure(error))
        }
    }

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            completion(.doNotRetry)
            return
        }

        refreshTokens { success in
            if success {
                completion(.retry)
                print("refresh token success")
            } else {
                do {
                    try Keychain.shared.deleteToken(kind: .accessToken)
                    try Keychain.shared.deleteToken(kind: .refreshToken)
                    print("Tokens successfully cleared from Keychain")
                } catch {
                    print("Failed to clear tokens from Keychain: \(error)")
                }
                NotificationCenter.default.post(name: Notification.Name("refreshTokenExpired"), object: nil)
                completion(.doNotRetry)
                print("refresh token failed")
            }
        }
    }

    private func refreshTokens(completion: @escaping (Bool) -> Void) {
        do {
            let refreshToken = try keychain.getToken(kind: .refreshToken)
            let headers: HTTPHeaders = ["RefreshToken": refreshToken]

            AF.request("https://drink-gourmet.kro.kr/auth/reissue-token", method: .post, headers: headers).responseJSON { response in
                switch response.result {
                case .success:
                    if let headers = response.response?.allHeaderFields,
                       let newAccessToken = headers["Authorization"] as? String {
                        self.keychain.saveToken(kind: .accessToken, token: newAccessToken)
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure:
                    completion(false)
                }
            }
        } catch {
            completion(false)
        }
    }
}
