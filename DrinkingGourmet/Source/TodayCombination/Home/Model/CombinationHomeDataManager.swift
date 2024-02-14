//
//  CombinationHomeDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/10/24.
//

import Alamofire

class CombinationHomeDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    private let testAccessToken: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJrYWthb18xMjM0NTY3ODkiLCJpYXQiOjE3MDc4MTY0OTQsImV4cCI6MTcwODQyMTI5NH0.tL3VWPK1W_3IR3_eIyOS0Lmn1qNTnfKRcb-nkNU7Glo"
    ]
    
    // MARK: - 오늘의 조합 홈 목록 가져오기
    func fetchCombinationHomeData(_ parameters: CombinationHomeInput,
                                  _ viewController: TodayCombinationViewController,
                                  completion: @escaping (CombinationHomeModel?) -> Void) {
        
        // Alamofire 요청
        AF.request("\(baseURL)/combinations",
                   method: .get,
                   parameters: parameters,
                   headers: testAccessToken)
        .validate()
        .responseDecodable(of: CombinationHomeModel.self) { response in
            switch response.result {
            case .success(let result):
                print("오늘의조합 홈 - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("오늘의조합 홈 - \(error)")
                completion(nil)
            }
        }
    }
/*
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("https://drink-gourmet.kro.kr/combinations",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: CombinationHomeModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("오늘의조합 홈 목록 가져오기 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("오늘의조합 홈 목록 가져오기 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
*/
    
    // MARK: - 오늘의 조합 검색 후 목록 가져오기
    func fetchCombinationDataForSearch(_ parameters: CombinationSearchInput,
                                       _ viewController: CombinationSearchVC,
                                       completion: @escaping (CombinationHomeModel?) -> Void) {
        
        AF.request("\(baseURL)/combinations/search",
                   method: .get,
                   parameters: parameters,
                   headers: testAccessToken)
        .validate()
        .responseDecodable(of: CombinationHomeModel.self) { response in
            switch response.result {
            case .success(let result):
                print("오늘의조합 검색 - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("오늘의조합 검색 - \(error)")
                completion(nil)
            }
        }
    }
}
