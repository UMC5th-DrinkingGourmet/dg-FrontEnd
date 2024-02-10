//
//  CombinationHomeDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/10/24.
//

import Alamofire

class CombinationHomeDataManager {
    func combinationHomeDataManager(_ parameters: CombinationHomeInput, _ viewController: TodayCombinationViewController, completion: @escaping (CombinationHomeModel?) -> Void) {
        AF.request("https://drink-gourmet.kro.kr/combinations", method: .get, parameters: parameters).validate().responseDecodable(of: CombinationHomeModel.self) { response in
            switch response.result {
            case .success(let result):
                print("TodayCombinationHomeDataManager - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("TodayCombinationHomeDataManager - \(error)")
                completion(nil)
            }
        }
    }
}
