//
//  CombinationDetailDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import Alamofire

class CombinationDetailDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    private let testAcessToken: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJrYWthb18xMjM0NTY3ODkiLCJpYXQiOjE3MDc4MTY0OTQsImV4cCI6MTcwODQyMTI5NH0.tL3VWPK1W_3IR3_eIyOS0Lmn1qNTnfKRcb-nkNU7Glo"
    ]
    
    // MARK: - 오늘의 조합 상세보기 조회
    func fetchCombinationDetailData(_ combinationID: Int, _ viewController: TodayCombinationDetailViewController, completion: @escaping (CombinationDetailModel?) -> Void) {

        AF.request("\(baseURL)/combinations/\(combinationID)", method: .get, headers: testAcessToken).validate().responseDecodable(of: CombinationDetailModel.self) { response in
            switch response.result {
            case .success(let result):
                print("오늘의 조합 상세정보 조회 - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("오늘의 조합 상세정보 조회 - \(error)")
                completion(nil)
            }
        }
    }
    
    // MARK: - 오늘의 조합 상세보기 댓글 페이징 조회
    func fetchCombinatiCommentData(_ combinationID: Int, _ parameters: CombinationCommentInput, _ viewController: TodayCombinationDetailViewController, completion: @escaping (CombinationCommentModel?) -> Void) {
        AF.request("\(baseURL)/combination-comments/\(combinationID)", method: .get, parameters: parameters).validate().responseDecodable(of: CombinationCommentModel.self) { response in
            switch response.result {
            case .success(let result):
                print("오늘의조합 댓글 조회 - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("오늘의조합 댓글 조회 - \(error)")
                completion(nil)
            }
        }
    }
}
