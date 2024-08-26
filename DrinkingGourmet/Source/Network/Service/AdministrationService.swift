//
//  AdministrationService.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 6/6/24.
//

import Alamofire

final class AdministrationService {
    
    static let shared = AdministrationService()
    private init() {}
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    private func getHeaders() throws -> HTTPHeaders {
        let accessToken = try Keychain.shared.getToken(kind: .accessToken)
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    // MARK: - 약관동의 (동의)
    func postAgree(termList: [String],
                   completion: @escaping (Error?) -> Void) {
        
        do {
            let headers = try getHeaders()
            
            let parameters: [String: Any] = [
                "termList": termList
            ]
            
            AF.request("\(baseURL)/term-agree/agree",
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
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
    
    // MARK: - 약관동의 (비동의)
    func postDisagree(termList: [String],
                      completion: @escaping (Error?) -> Void) {
        
        do {
            let headers = try getHeaders()
            
            let parameters: [String: Any] = [
                "termList": termList
            ]
            
            AF.request("\(baseURL)/term-agree/disagree",
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
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
    
    // MARK: - 신고하기
    func postReport(resourceId: Int,
                    reportTarget: String,
                    reportReason: String, // 신고 유형
                    content: String, // 해당 게시물 or 댓글 내용
                    reportContent: String, // 신고 내용
                    reportedMemberId: Int, // 신고 당하는 MemberId
                    completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters: [String: Any] = [
                "resourceId": resourceId,
                "reportTarget": reportTarget,
                "reportReason": reportReason,
                "content": content,
                "reportContent": reportContent,
                "reportedMemberId" : reportedMemberId
            ]
            
            AF.request("\(baseURL)/member/reports",
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
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
    
    // MARK: - 차단하기
    func postBlock(blockedMemberId: Int, 
                   completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters: [String: Any] = [
                "blockedMemberId": blockedMemberId
            ]
            
            AF.request("\(baseURL)/member/blocks",
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
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
