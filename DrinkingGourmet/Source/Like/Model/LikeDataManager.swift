//
//  LikeDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/17/24.
//

import Alamofire

class LikeDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 좋아요 한 오늘의 조합 조회
    func fetchLikeAllCombinationData (_ parameters: LikeInput,
                                      _ viewController: LikeViewController,
                                      completion: @escaping (LikeAllCombinationModel?) -> Void) {
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/combinations/likes",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: LikeAllCombinationModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("좋아요 한 오늘의 조합 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("좋아요 한 오늘의 조합 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 좋아요 한 레시피 조회
    func fetchLikeAllRecipeBookData (_ parameters: LikeInput,
                                     _ viewController: LikeViewController,
                                     completion: @escaping (LikeAllRecipeBookModel?) -> Void) {
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/recipes/likes",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: LikeAllRecipeBookModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("좋아요 한 레시피북 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("좋아요 한 레시피북 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
}
