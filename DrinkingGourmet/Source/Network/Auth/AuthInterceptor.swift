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
            let accessToken = try keychain.getToken(kind: .accessToken)
            let refreshToken = try keychain.getToken(kind: .refreshToken)

            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)",
                "RefreshToken": refreshToken
            ]

            AF.request("https://drink-gourmet.kro.kr/auth/reissue-token", method: .post, headers: headers)
                .validate(statusCode: 200..<300)
                .response { response in
                    guard let httpResponse = response.response else {
                        print("서버 응답이 없음")
                        completion(false)
                        return
                    }
                    
                    if httpResponse.statusCode == 200,
                       let authorization = httpResponse.allHeaderFields["Authorization"] as? String {
                        self.keychain.saveToken(kind: .accessToken, token: authorization)
                        print("새로운 액세스 토큰 저장: \(authorization)")
                        completion(true)
                    } else {
                        print("새로운 액세스 토큰을 찾을 수 없음 또는 상태 코드가 200이 아님")
                        completion(false)
                    }
                }
        } catch {
            print("토큰을 가져오는 중 오류 발생: \(error.localizedDescription)")
            completion(false)
        }
    }
}
