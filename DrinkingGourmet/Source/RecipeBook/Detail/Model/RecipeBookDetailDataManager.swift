//
//  RecipeBookDetailDataManager.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/14/24.
//

import Alamofire

class RecipeBookDetailDataManager {
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 레시피북 상세정보 조회
    func fetchRecipeBookDetailData(_ recipeBookId: Int, _ viewController: RecipeBookDetailVC, completion: @escaping (RecipeBookDetailModel?) -> Void) {
        
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/recipes/\(recipeBookId)",
                       method: .get,
                       headers: headers)
            .validate()
            .responseDecodable(of: RecipeBookDetailModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("레시피북 상세정보 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("레시피북 상세정보 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 레시피북 댓글 페이징 조회
    func fetchRecipeBookCommentData (_ recipeBookId: Int,
                                     _ parameters: RecipeBookCommentInput.fetchRecipeBookCommentDataInput,
                                     _ viewController: RecipeBookDetailVC,
                                     completion: @escaping (RecipeBookCommentModel?) -> Void) {
        
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/recipe-comments/\(recipeBookId)",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: RecipeBookCommentModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("레시피북 페이징 조회 - 네트워킹 성공")
                    completion(result)
                case .failure(let error):
                    print("레시피북 댓글 페이징 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 오늘의 조합 댓글 작성
    func postComment (_ recipeBookId: Int,
                      _ parameters: RecipeBookCommentInput.postCommentInput) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/recipe-comments/\(recipeBookId)",
                       method: .post,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default,
                       headers: headers).responseJSON { response in
                switch response.result {
                case .success(_):
                    print("레시피북 댓글 작성 성공")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 레시피북 댓글 삭제
    func deleteComment(recipeCommentId: Int) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            let parameters: Parameters = [
                "recipeCommentId": recipeCommentId
            ]
            
            AF.request("\(baseURL)/recipe-comments",
                       method: .delete,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(_):
                    print("레시피북 댓글 삭제 - 네트워킹 성공")
                case .failure(let error):
                    print("레시피북 댓글 삭제 - \(error)")
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 레시피북 게시물 삭제
    func deleteRecipeBook (_ recipeBookId: Int) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/recipes/\(recipeBookId)",
                       method: .delete,
                       headers: headers)
            .validate()
            .response { response in
                switch response.result {
                case .success(_):
                    print("레시피북 게시물 삭제 - 네트워킹 성공")
                case .failure(let error):
                    print("레시피북 게시물 삭제 - \(error)")
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 레시피북 좋아요 누르기
    func postLike (_ recipeBookId: Int) {
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)"
            ]
            
            AF.request("\(baseURL)/recipe-likes/\(recipeBookId)",
                       method: .post,
                       headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    print("레시피북 좋아요 누르기 - 네트워킹 성공")
                case .failure(let error):
                    print("레시피북 좋아요 누르기 - \(error)")
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
}
