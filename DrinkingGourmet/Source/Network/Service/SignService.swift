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
    
    private let baseURL = "https://drink-gourmet.kro.kr/auth"
    private let headers: HTTPHeaders = ["Content-Type": "application/json"]
    
    private func getHeaders() throws -> HTTPHeaders {
        let accessToken = try Keychain.shared.getToken(kind: .accessToken)
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    func sendUserInfo(_ userInfo: UserInfo, completion: @escaping (UserStatus?) -> Void) {
        let parameter = UserInfoDTO(from: userInfo)
        
        AF.request("\(baseURL)/kakao",
                   method: .post,
                   parameters: parameter,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: UserStatusResponseDTO.self) { response in
            self.handleResponse(response, completion: completion)
        }
    }

    func checkUserDivision(signInfo: SignInfoDTO, completion: @escaping (UserDivision?) -> Void) {
        let url = "\(baseURL)/user-division"
        
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
        let provider = UserDefaultManager.shared.provider
        let providerId = UserDefaultManager.shared.providerId
        let loginInfo = SignInfoDTO(provider: provider, providerId: providerId)
        
        AF.request("\(baseURL)/kakao",
                   method: .post,
                   parameters: loginInfo,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
        .validate(statusCode: 200..<601)
        .responseDecodable(of: UserStatusResponseDTO.self) { response in
            self.handleResponse(response) { _ in
                completion()
            }
        }
    }

    func logout(completion: @escaping (Bool) -> Void) {
        guard let accessToken = try? Keychain.shared.getToken(kind: .accessToken),
              let refreshToken = try? Keychain.shared.getToken(kind: .refreshToken) else {
            completion(false)
            return
        }

        let url = "\(baseURL)/logout"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "RefreshToken": refreshToken
        ]

        AF.request(url,
                   method: .patch,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: LogoutResponseDTO.self) { response in
            switch response.result {
            case .success(let logoutResponse):
                if logoutResponse.isSuccess {
                    completion(true)
                } else {
                    print("서버 로그아웃 실패: \(logoutResponse.message)")
                    completion(false)
                }
            case .failure(let error):
                print("서버 로그아웃 요청 실패: \(error.localizedDescription)")
                completion(false)
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
    
    // MARK: - 회원탈퇴
    func postCancellations(completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            AF.request("https://drink-gourmet.kro.kr/users/cancellations",
                       method: .post,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
    
}
