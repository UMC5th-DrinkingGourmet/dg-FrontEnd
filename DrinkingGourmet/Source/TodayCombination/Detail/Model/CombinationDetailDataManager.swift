//
//  CombinationDetailDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import Alamofire

class CombinationDetailDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 오늘의 조합 상세정보 조회
    func fetchCombinationDetailData (_ combinationID: Int,
                                     _ viewController: TodayCombinationDetailViewController,
                                     completion: @escaping (CombinationDetailModel?) -> Void) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/combinations/\(combinationID)",
                       method: .get,
                       headers: headers)
            .validate()
            .responseDecodable(of: CombinationDetailModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("오늘의 조합 상세정보 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("오늘의 조합 상세정보 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 오늘의 조합 댓글 페이징 조회
    func fetchCombinatiCommentData (_ combinationID: Int,
                                    _ parameters: CombinationCommentInput.fetchCombinatiCommentDataInput,
                                    _ viewController: TodayCombinationDetailViewController,
                                    completion: @escaping (CombinationCommentModel?) -> Void) {
        
        AF.request("\(baseURL)/combination-comments/\(combinationID)",
                   method: .get,
                   parameters: parameters)
        .validate()
        .responseDecodable(of: CombinationCommentModel.self) { response in
            switch response.result {
            case .success(let result):
                print("오늘의 조합 댓글 페이징 조회 - 네트워킹 성공")
                completion(result)
            case .failure(let error):
                print("오늘의 조합 댓글 페이징 조회 - \(error)")
                completion(nil)
            }
        }
    }
    
    // MARK: - 오늘의 조합 댓글 작성
    func postComment (_ combinationID: Int,
                      _ parameters: CombinationCommentInput.postCommentInput) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/combination-comments/\(combinationID)",
                       method: .post,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default,
                       headers: headers).responseJSON { response in
                switch response.result {
                case .success(_):
                    print("댓글 작성 성공")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    
    // MARK: - 오늘의 조합 삭제
    func deleteCombination (_ combinationID: Int) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/combinations/\(combinationID)",
                       method: .delete,
                       headers: headers)
            .validate()
            .responseDecodable(of: CombinationDetailModel.self) { response in
                switch response.result {
                case .success(_):
                    print("오늘의 조합 삭제 - 네트워킹 성공")
                case .failure(let error):
                    print("오늘의 조합 삭제 - \(error)")
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 오늘의 조합 좋아요 누르기
    func postLike (_ combinationID: Int) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/combination-likes/\(combinationID)",
                       method: .post,
                       headers: headers).responseJSON { response in
                switch response.result {
                case .success(_):
                    print("오늘의 조합 좋아요 누르기 - 네트워킹 성공")
                case .failure(let error):
                    print("오늘의 조합 좋아요 누르기 - \(error)")
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
}
