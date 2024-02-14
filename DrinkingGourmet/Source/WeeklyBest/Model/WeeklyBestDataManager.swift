//
//  WeeklyBestDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import Alamofire

class WeeklyBestDataManager {

    private let baseURL = "https://drink-gourmet.kro.kr"
    private let testAccessToken: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJrYWthb18xMjM0NTY3ODkiLCJpYXQiOjE3MDc4MTY0OTQsImV4cCI6MTcwODQyMTI5NH0.tL3VWPK1W_3IR3_eIyOS0Lmn1qNTnfKRcb-nkNU7Glo"
    ]

    // MARK: - 주간 베스트 조합 조회
    func fetchWeeklyBestData(_ parameters: WeeklyBestInput,
                                  _ viewController: WeeklyBestVC,
                                  completion: @escaping (WeeklyBestModel?) -> Void) {

        // Alamofire 요청
        AF.request("\(baseURL)/combinations/weekly-best",
                   method: .get,
                   parameters: parameters,
                   headers: testAccessToken)
        .validate()
        .responseDecodable(of: WeeklyBestModel.self) { response in
            switch response.result {
            case .success(let result):
                print("주간 베스트 조합 - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("주간 베스트 조합 - \(error)")
                completion(nil)
            }
        }
    }

    // MARK: - 주간 베스트 조합 검색
    func fetchWeeklyBestDataForSearch(_ parameters: WeeklyBestSearchInput,
                                       _ viewController: WeeklyBestSearchVC,
                                       completion: @escaping (WeeklyBestModel?) -> Void) {

        AF.request("\(baseURL)/combinations/weekly-best/search",
                   method: .get,
                   parameters: parameters,
                   headers: testAccessToken)
        .validate()
        .responseDecodable(of: WeeklyBestModel.self) { response in
            switch response.result {
            case .success(let result):
                print("주간 베스트 조합 검색 - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("주간 베스트 조합 검색 - \(error)")
                completion(nil)
            }
        }
    }
}
