//
//  MyPageService.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 7/5/24.
//

import Alamofire

final class MyPageService {
    
    static let shared = MyPageService()
    private init() {}
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    private func getHeaders() throws -> HTTPHeaders {
        let accessToken = try Keychain.shared.getToken(kind: .accessToken)
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    // MARK: - 내 정보 조회
    func getMyInfo (completion: @escaping (Swift.Result<MyInfoResponseDTO, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            AF.request("\(baseURL)/users",
                       method: .get,
                       headers: headers)
            .validate()
            .responseDecodable(of: MyInfoResponseDTO.self) { response in
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
    
    // MARK: - 내 정보 수정
    func patchMyInfo (name: String,
                      birthDate: String,
                      phoneNumber: String,
                      gender: String,
                      nickName: String,
                      completion: @escaping (Error?) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String : Any] = [
                "name" : name,
                "birthDate" : birthDate,
                "phoneNumber" : phoneNumber,
                "gender" : gender,
                "nickName" : nickName
            ]
            
            print(parameters)
            
            AF.request("\(baseURL)/users",
                       method: .patch,
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
    
    // MARK: - 나의 주류 추천 페이징 조회
    func getMyRecommend (page: Int,
                         size: Int,
                         completion: @escaping (Swift.Result<MyRecommendResponseDTO, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String : Any] = [
                "page" : page,
                "size" : size
            ]
            
            AF.request("\(baseURL)/recommends/list",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: MyRecommendResponseDTO.self) { response in
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
    
    // MARK: - 나의 오늘의 조합 페이징 조회
    func getMyCombination (page: Int,
                           completion: @escaping (Swift.Result<MyCombinationResponseDTO, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String : Any] = [
                "page" : page
            ]
            
            AF.request("\(baseURL)/combinations/my-page",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: MyCombinationResponseDTO.self) { response in
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
    
    // MARK: - 나의 레시피북 페이징 조회
    func getMyRecipeBook (page: Int,
                          completion: @escaping (Swift.Result<MyRecipeBookResponseDTO, Error>) -> Void) {
        do {
            let headers = try getHeaders()
            
            let parameters : [String : Any] = [
                "page" : page
            ]
            
            AF.request("\(baseURL)/recipes/my-page",
                       method: .get,
                       parameters: parameters,
                       headers: headers)
            .validate()
            .responseDecodable(of: MyRecipeBookResponseDTO.self) { response in
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
