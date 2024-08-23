//
//  RecipeBookService.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 6/6/24.
//

import Alamofire

final class RecipeBookService {
    
    static let shared = RecipeBookService()
    private init() {}
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    private func getHeaders() throws -> HTTPHeaders {
        let accessToken = try Keychain.shared.getToken(kind: .accessToken)
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    // MARK: - 레시피북 홈 페이징 조회
    func getAll(page: Int,
                completion: @escaping (Swift.Result<RecipeBookHomeResponseDTO, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String: Any] = [
                "page" : page
            ]
            
            AF.request("\(baseURL)/recipes",
                       method: .get,
                       parameters: parameters,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .responseDecodable(of: RecipeBookHomeResponseDTO.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 레시피북 검색 페이징 조회
    func getSearch(page: Int,
                   keyword: String,
                   completion: @escaping (Swift.Result<RecipeBookHomeResponseDTO, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String: Any] = [
                "page" : page,
                "keyword": keyword
            ]
            
            AF.request("\(baseURL)/recipes/search",
                       method: .get,
                       parameters: parameters,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .responseDecodable(of: RecipeBookHomeResponseDTO.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 레시피북 상세 조회
    func getDetail(recipeBookId: Int,
                   completion: @escaping (Swift.Result<RecipeBookDetailResponseDTO, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            AF.request("\(baseURL)/recipes/\(recipeBookId)",
                       method: .get,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .responseDecodable(of: RecipeBookDetailResponseDTO.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 레시피북 좋아요 누르기
    func postLike(recipeBookId: Int,
                  completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            AF.request("\(baseURL)/recipe-likes/\(recipeBookId)",
                       method: .post,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 레시피북 수정
    func patchRecipeBook(recipeBookId: Int,
                         patchModel: RecipeBookUploadModel.RecipeRequestDTO,
                         completion: @escaping (Error?) -> Void) {
        
        do {
            let headers = try getHeaders()
            
            print("********\(patchModel)")
            
            AF.request("\(baseURL)/recipes/\(recipeBookId)",
                       method: .patch,
                       parameters: patchModel,
                       encoder: JSONParameterEncoder.default,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 레시피북 삭제
    func deleteRecipeBook(recipeBookId: Int,
                          completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            AF.request("\(baseURL)/recipes/\(recipeBookId)",
                       method: .delete,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 레시피북 댓글 페이징 조회
    func getAllComment(recipeBookId: Int,
                       page: Int,
                       completion: @escaping (Swift.Result<RecipeBookCommentResponseDTO, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String: Any] = [
                "page" : page
            ]
            
            AF.request("\(baseURL)/recipe-comments/\(recipeBookId)",
                       method: .get,
                       parameters: parameters,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .responseDecodable(of: RecipeBookCommentResponseDTO.self) { response in
                switch response.result {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 레시피북 댓글 작성
    func postComment(recipeBookId: Int,
                     content: String,
                     parentId: Int,
                     completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String: Any] = [
                "content" : content,
                "parentId" : parentId
            ]
            
            AF.request("\(baseURL)/recipe-comments/\(recipeBookId)",
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
    
    // MARK: - 오늘의 조합 댓글 삭제
    func deleteComment(recipeCommentId: Int,
                       completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters: [String : Any] = [
                "recipeCommentId" : recipeCommentId
            ]
            
            AF.request("\(baseURL)/recipe-comments",
                       method: .delete,
                       parameters: parameters,
                       headers: headers,
                       interceptor: AuthInterceptor())
            .validate()
            .response { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        } catch {
            print("Failed to get access token: \(error.localizedDescription)")
        }
    }
}
