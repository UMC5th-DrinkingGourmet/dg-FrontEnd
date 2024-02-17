//
//  CombinationUploadDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/16/24.
//

import Alamofire

class CombinationUploadDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 오늘의 조합 홈 조회
    func fetchRecommendListData(_ parameters: CombinationUploadInput.fetchRecommendListDataInput,
                                  _ viewController: CombinationUploadVC,
                                    completion: @escaping (CombinationUploadModel.fetchRecommendListModel?) -> Void) {
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/recommends/list",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: CombinationUploadModel.fetchRecommendListModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("추천 받은 조합 리스트 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("추천 받은 조합 리스트 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
}
