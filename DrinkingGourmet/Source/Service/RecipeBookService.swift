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
                       headers: headers)
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
                       headers: headers)
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
    
    // MARK: - 오늘의 조합 상세 조회
    func getDetail(combinationId: Int,
                   completion: @escaping (Swift.Result<CombinationDetailResponseDto, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            AF.request("\(baseURL)/combinations/\(combinationId)",
                       method: .get,
                       headers: headers)
            .validate()
            .responseDecodable(of: CombinationDetailResponseDto.self) { response in
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
    
    // MARK: - 오늘의 조합 좋아요 누르기
    func postLike(combinationId: Int,
                  completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            AF.request("\(baseURL)/combination-likes/\(combinationId)",
                       method: .post,
                       headers: headers)
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
    
    // MARK: - 오늘의 조합 삭제
    func deleteCombination(combinationId: Int,
                           completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            AF.request("\(baseURL)/combinations/\(combinationId)",
                       method: .delete,
                       headers: headers)
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
    
    // MARK: - 오늘의 조합 댓글 페이징 조회
    func getAllComment(combinationId: Int,
                       page: Int,
                       completion: @escaping (Swift.Result<CombinationCommentResponseDto, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String: Any] = [
                "page" : page
            ]
            
            AF.request("\(baseURL)/combination-comments/\(combinationId)",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: CombinationCommentResponseDto.self) { response in
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
    
    // MARK: - 오늘의 조합 댓글 작성
    func postComment(combinationId: Int,
                     content: String,
                     parentId: String,
                     completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String: Any] = [
                "content" : content,
                "parentId" : parentId
            ]
            
            AF.request("\(baseURL)/combination-comments/\(combinationId)",
                       method: .post,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
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
    func deleteComment(commentId: Int,
                       completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            AF.request("\(baseURL)/combination-comments/\(commentId)",
                       method: .delete,
                       headers: headers)
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
    
    // MARK: - 주간 베스트 조합 홈 페이징 조회
    func getAllWeeklyBest(page: Int,
                          completion: @escaping (Swift.Result<CombinationHomeResponseDto, Error>) -> Void) {
        
        do {
            let headers = try getHeaders()
            
            let parameters : [String: Any] = [
                "page" : page
            ]
            
            AF.request("\(baseURL)/combinations/weekly-best",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: CombinationHomeResponseDto.self) { response in
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
    
    
    // MARK: - 주간 베스트 조합 검색
    func getSearchWeeklyBest(page: Int,
                             keyword: String,
                             completion: @escaping (Swift.Result<CombinationHomeResponseDto, Error>) -> Void) {
        
        do {
            let headers = try getHeaders()
            
            let parameters : [String: Any] = [
                "page" : page,
                "keyword": keyword
            ]
            
            AF.request("\(baseURL)/combinations/weekly-best/search",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: CombinationHomeResponseDto.self) { response in
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
    
}

