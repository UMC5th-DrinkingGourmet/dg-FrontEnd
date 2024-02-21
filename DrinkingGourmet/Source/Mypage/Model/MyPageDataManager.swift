//
//  MyPageDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

import Alamofire

class MyPageDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 회원정보 조회
    func fetchUserData (_ viewController: MyPageViewController,
                        completion: @escaping (MyPageUserModel?) -> Void) {
                                      
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/users",
                       method: .get,
                       headers: headers)
            .validate()
            .responseDecodable(of: MyPageUserModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("회원정보 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("회원정보 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 내가 받은 추천 리스트 조회
    func fetchRecommendListData (_ parameters: MyPageInput.fetchRecommendListDataInput,
                                 _ viewController: MyPageViewController,
                                 completion: @escaping (MyPageRecommendModel?) -> Void) {
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
            .responseDecodable(of: MyPageRecommendModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("내가 받은 추천 리스트 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("내가 받은 추천 리스트 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 내가 작성한 오늘의 조합 게시물 조회
    func fetchCombinationData (_ parameters: MyPageInput.fetchCombinationDataInput,
                                 _ viewController: MyPageViewController,
                                 completion: @escaping (MyPageCombinationModel?) -> Void) {
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/combinations/my-page",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: MyPageCombinationModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("내가 작성한 오늘의 조합 게시물 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("내가 작성한 오늘의 조합 게시물 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // 내가 작성한 레시피북 조회
    func fetchRecipeBookData (_ parameters: MyPageInput.fetchRecipeBookDataInput,
                              _ viewController: MyPageViewController,
                              completion: @escaping (MyPageRecipeBookModel?) -> Void) {
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/recipes/my-page",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: MyPageRecipeBookModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("내가 작성한 레시피북 게시물 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("내가 작성한 레시피북 게시물 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // 내가 작성한 레시피북 조회
    func fetchRecommendDetailData (_ recommendId: Int,
                                   _ viewController: MyPageViewController,
                                   completion: @escaping (RecommendDetailResponseModel?) -> Void) {
        do {
            // Keychain에서 액세스 토큰 가져오기
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            // 헤더 구성
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            // Alamofire 요청
            AF.request("\(baseURL)/recommends/\(recommendId)",
                       method: .post,
                       headers: headers)
            .validate()
            .responseDecodable(of: RecommendDetailResponseModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("추천 받은 조합 상세보기 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("추천 받은 조합 상세보기 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
}
