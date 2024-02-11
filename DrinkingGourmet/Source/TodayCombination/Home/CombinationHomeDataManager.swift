//
//  CombinationHomeDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/10/24.
//

import Alamofire

class CombinationHomeDataManager {
    func fetchCombinationHomeData(_ parameters: CombinationHomeInput, _ viewController: TodayCombinationViewController, completion: @escaping (CombinationHomeModel?) -> Void) {
        AF.request("https://drink-gourmet.kro.kr/combinations", method: .get, parameters: parameters).validate().responseDecodable(of: CombinationHomeModel.self) { response in
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
    
    func fetchCombinationDataForSearch(_ parameters: CombinationSearchInput, _ viewController: CombinationSearchVC, completion: @escaping (CombinationHomeModel?) -> Void) {
        AF.request("https://drink-gourmet.kro.kr/combinations/search", method: .get, parameters: parameters).validate().responseDecodable(of: CombinationHomeModel.self) { response in
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
