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

            AF.request("https://drink-gourmet.kro.kr/auth/reissue-token", method: .post, headers: headers)
                .validate(statusCode: 200..<300)  // 상태 코드 범위를 200~299로 수정
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if let headers = response.response?.allHeaderFields,
                           let newAccessToken = headers["Authorization"] as? String {
                            self.keychain.saveToken(kind: .accessToken, token: newAccessToken)
                            print("새로운 액세스 토큰 저장: \(newAccessToken)")
                            completion(true)
                        } else {
                            print("새로운 액세스 토큰을 찾을 수 없음")
                            completion(false)
                        }
                    case .failure(let error):
                        print("리프레시 토큰 갱신 실패: \(error.localizedDescription)")
                        completion(false)
                    }
                }
        } catch {
            print("리프레시 토큰을 가져오는 중 오류 발생: \(error.localizedDescription)")
            completion(false)
        }
    }
}
