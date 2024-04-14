//
//  ReportDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 4/14/24.
//

import Alamofire

final class ReportDataManager {
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // 신고하기
    func postReport(resourceId: Int,
                    reportTarget: String,
                    reportReason: String,
                    content: String,
                    reportContent: String) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json"
            ]
            
            let parameters: [String: Any] = [
                "resourceId": resourceId,
                "reportTarget": reportTarget,
                "reportReason": reportReason,
                "content": content,
                "reportContent": reportContent
            ]
            
            AF.request("\(baseURL)/member/reports",
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers).response { response in
                if let statusCode = response.response?.statusCode, 200..<300 ~= statusCode {
                    print("\(reportTarget) \(resourceId) 신고하기 - 네트워킹 성공")
                } else {
                    print("\(reportTarget) \(resourceId) 신고하기 - 실패: 상태 코드 \(response.response?.statusCode ?? -1)")
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
}
