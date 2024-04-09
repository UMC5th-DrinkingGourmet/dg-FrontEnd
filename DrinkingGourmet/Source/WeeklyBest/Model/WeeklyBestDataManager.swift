//
//  WeeklyBestDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import Alamofire

class WeeklyBestDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 주간 베스트 조합 조회
    func fetchWeeklyBestData(_ parameters: fetchWeeklyBestDataInput,
                             _ viewController: WeeklyBestVC,
                             completion: @escaping (WeeklyBestModel?) -> Void) {
        
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/combinations/weekly-best",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: WeeklyBestModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("주간 베스트 조합 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("주간 베스트 조합 - 네트워킹 성공 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    
    
    // MARK: - 주간 베스트 조합 검색
    func fetchWeeklyBestDataForSearch(_ parameters: fetchweeklyBestDataForSearchInput,
                                      _ viewController: WeeklyBestVC,
                                      completion: @escaping (WeeklyBestModel?) -> Void) {
        
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/combinations/weekly-best/search",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: WeeklyBestModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("주간 베스트 조합 검색 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("주간 베스트 조합 검색 - 네트워킹 성공 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
}
