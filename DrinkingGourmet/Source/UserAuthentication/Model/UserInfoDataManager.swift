//
//  UserInfoDataManager.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/9/24.
//

import Foundation
import Alamofire

class UserInfoDataManager {
    static let shared = UserInfoDataManager()
    
    private init() { }
    
    func sendUserInfo(_ parameter: UserInfoModel, completion: @escaping () -> Void) {
        print("sendUserInfo providerId: \(UserDefaultManager.shared.providerId)")
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request("https://drink-gourmet.kro.kr/auth/kakao",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .validate()
        .response { response in
            switch response.result {
            case .success:
                if let headerFields = response.response?.allHeaderFields as? [String: String],
                    let url = response.request?.url {
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
            case .failure(let failure):
                print("Request Failed: \(failure)")
            }
        }
    }
    
    func loginWithProviderInfo(completion: @escaping () -> Void) {
        print("loginWithProviderInfo providerId: \(UserDefaultManager.shared.providerId)")
        let provider = UserDefaultManager.shared.provider
        let providerId = UserDefaultManager.shared.providerId
        
        let loginInfo = LoginInfoModel(provider: provider, providerId: providerId)
        
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        
        AF.request("https://drink-gourmet.kro.kr/auth/kakao",
                   method: .post,
                   parameters: loginInfo,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .validate(statusCode: 200..<601)
        .response { response in
            switch response.result {
            case .success:
                if let headerFields = response.response?.allHeaderFields as? [String: String],
                    let url = response.request?.url {
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

}
