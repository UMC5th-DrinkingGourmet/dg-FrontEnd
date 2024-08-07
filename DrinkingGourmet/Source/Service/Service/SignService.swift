//
//  SignUpService.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 7/1/24.
//

import Foundation
import Alamofire

final class SignService {
    
    static let shared = SignService()
    
    private init() {}
    
    private let baseURL = "https://drink-gourmet.kro.kr/auth/kakao"
    private let headers: HTTPHeaders = ["Content-Type": "application/json"]
    
    func sendUserInfo(_ parameter: UserInfoDTO, completion: @escaping (UserStatusResponse?) -> Void) {
        print("sendUserInfo providerId: \(UserDefaultManager.shared.providerId)")
        
        AF.request(baseURL,
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: headers,
                   interceptor: AuthInterceptor())
        .validate()
        .responseDecodable(of: UserStatusResponse.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }
    
    func loginWithProviderInfo(completion: @escaping () -> Void) {
        print("loginWithProviderInfo providerId: \(UserDefaultManager.shared.providerId)")
        let provider = UserDefaultManager.shared.provider
        let providerId = UserDefaultManager.shared.providerId
        let loginInfo = SignInfoDTO(provider: provider, providerId: providerId)
        
        AF.request(baseURL,
                   method: .post,
                   parameters: loginInfo,
                   encoder: JSONParameterEncoder.default,
                   headers: headers,
                   interceptor: AuthInterceptor())
        .validate(statusCode: 200..<601)
        .response { response in
            self.handleResponse(response) {
                completion()
            }
        }
    }
    
    // checkUserDivision 메서드 수정
    func checkUserDivision(signInfo: SignInfoDTO, completion: @escaping (Bool?) -> Void) {
        let url = "https://drink-gourmet.kro.kr/auth/user-division"
        
        AF.request(url,
                   method: .post,
                   parameters: signInfo,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UserDivisionResponse.self) { response in
            switch response.result {
            case .success(let userDivisionResponse):
                completion(userDivisionResponse.result.isSignedUp)
            case .failure(let error):
                print("회원 구분 요청 실패: \(error)")
                completion(nil)
            }
        }
    }
    
    private func handleResponse(_ response: AFDataResponse<UserStatusResponse>, completion: @escaping (UserStatusResponse?) -> Void) {
        switch response.result {
        case .success(let userStatusResponse):
            if let headerFields = response.response?.allHeaderFields as? [String: String] {
                if let refreshToken = headerFields["RefreshToken"] {
                    Keychain.shared.saveToken(kind: .refreshToken, token: refreshToken)
                    print("Saved Refresh Token: \(refreshToken)")
                }
                
                if let accessToken = headerFields["Authorization"] {
                    Keychain.shared.saveToken(kind: .accessToken, token: accessToken)
                    print("Saved Access Token: \(accessToken)")
                }
            }
            completion(userStatusResponse)
            
        case .failure(let failure):
            print("Request Failed: \(failure)")
            completion(nil)
        }
    }
    
    private func handleResponse(_ response: AFDataResponse<Data?>, completion: @escaping () -> Void) {
        switch response.result {
        case .success:
            if let headerFields = response.response?.allHeaderFields as? [String: String] {
                if let refreshToken = headerFields["RefreshToken"] {
                    Keychain.shared.saveToken(kind: .refreshToken, token: refreshToken)
                    print("Saved Refresh Token: \(refreshToken)")
                }
                
                if let accessToken = headerFields["Authorization"] {
                    Keychain.shared.saveToken(kind: .accessToken, token: accessToken)
                    print("Saved Access Token: \(accessToken)")
                    completion()
                }
            }
            
            if let data = response.data, let str = String(data: data, encoding: .utf8) {
                print("Server Response: \(str)")
                print(UserDefaultManager.shared.userGender)
            }
        case .failure(let failure):
            print("Request Failed: \(failure)")
        }
    }
}
