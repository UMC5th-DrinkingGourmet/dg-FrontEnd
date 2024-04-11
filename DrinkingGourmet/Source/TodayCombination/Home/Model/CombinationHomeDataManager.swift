//
//  CombinationHomeDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/10/24.
//

import Alamofire

class CombinationHomeDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 오늘의 조합 홈 조회
    func fetchCombinationHomeData(_ parameters: CombinationHomeInput.fetchCombinationHomeDataInput,
                                  _ viewController: TodayCombinationViewController,
                                  completion: @escaping (CombinationHomeModel?) -> Void) {
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/combinations",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: CombinationHomeModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("오늘의 조합 홈 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("오늘의 조합 홈 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }

    
    // MARK: - 오늘의 조합 검색
    func fetchCombinationSearchData (_ parameters: CombinationHomeInput.fetchCombinationSearchDataInput,
                                       _ viewController: TodayCombinationViewController,
                                       completion: @escaping (CombinationHomeModel?) -> Void) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/combinations/search",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: CombinationHomeModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("오늘의 조합 검색 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("오늘의 조합 검색 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
}
