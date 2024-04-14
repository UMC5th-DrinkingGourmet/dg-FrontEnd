//
//  ReportDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 4/14/24.
//

import Alamofire

class ReportDataManager {
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 신고하기
    func postReport (resourceId: Int,
                     reportTarget: String,
                     reportReason: String,
                     content: String, // 신고 내용
                     reportContent: String) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/member/reports)",
                       method: .post,
                       headers: headers)
            .response { response in
                switch response.result {
                case .success(_):
                    print("신고하기 - 네트워킹 성공")
                case .failure(let error):
                    print("신고하기 - \(error)")
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
}
