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
    
    func sendUserInfo(_ userInfo: UserInfo, completion: @escaping (UserStatus?) -> Void) {
        let parameter = UserInfoDTO(from: userInfo)
        
        AF.request(baseURL,
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: headers,
                   interceptor: AuthInterceptor())
        .validate()
        .responseDecodable(of: UserStatusResponseDTO.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }

    
    func checkUserDivision(signInfo: SignInfoDTO, completion: @escaping (UserDivision?) -> Void) {
        let url = "https://drink-gourmet.kro.kr/auth/user-division"
        
        AF.request(url,
                   method: .post,
                   parameters: signInfo,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: UserDivisionResponseDTO.self) { response in
            switch response.result {
            case .success(let userDivisionResponse):
                completion(userDivisionResponse.toDomain())
            case .failure(let error):
                print("회원 구분 요청 실패: \(error)")
                completion(nil)
            }
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
        .responseDecodable(of: UserStatusResponseDTO.self) { response in
            self.handleResponse(response) { _ in
                completion()
            }
        }
    }
    
    private func handleResponse(_ response: AFDataResponse<UserStatusResponseDTO>, completion: @escaping (UserStatus?) -> Void) {
        switch response.result {
        case .success(let userStatusResponseDTO):
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
            
            if userStatusResponseDTO.isSuccess {
                completion(userStatusResponseDTO.result.toDomain())
            } else {
                print("Request Failed: \(userStatusResponseDTO.message)")
                completion(nil)
            }
            
        case .failure(let failure):
            print("Request Failed: \(failure)")
            completion(nil)
        }
    }
}
