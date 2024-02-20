//
//  RecipeBookUploadDataManager.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/20/24.
//

import UIKit
import Alamofire

class RecipeBookUploadDataManager {
    static let shared = RecipeBookUploadDataManager()
    
    private init() { }
    
    private let baseURL = "https://drink-gourmet.kro.kr"
    
    // MARK: - 조합 조회
    func fetchRecommendListData(_ parameters: CombinationUploadInput.fetchRecommendListDataInput,
                                _ viewController: RecipeBookUploadViewController,
                                completion: @escaping (CombinationUploadModel.fetchRecommendListModel?) -> Void) {
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
            .responseDecodable(of: CombinationUploadModel.fetchRecommendListModel.self) { response in
                switch response.result {
                case .success(let result):
                    print("추천 받은 조합 리스트 조회 - 네트워킹 성공")
                    print("result: \(result)")
                    completion(result)
                case .failure(let error):
                    print("추천 받은 조합 리스트 조회 - \(error)")
                    completion(nil)
                }
            }
        } catch {
            print("Failed to get access token")
        }
    }
    
    // MARK: - 레시피북 이미지 업로드
    func uploadImages(_ images: [UIImage], completion: @escaping (Result<RecipeBookUpoadModel.ImageUploadResponse, Error>) -> Void) {
        let url = "\(baseURL)/recipes-images"
        
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "multipart/form-data"
            ]
            
            AF.upload(multipartFormData: { multipartFormData in
                for (index, image) in images.enumerated() {
                    if let jpegData = image.jpegData(compressionQuality: 0.2) {
                        multipartFormData.append(jpegData,
                                                 withName: "file",
                                                 fileName: "image\(index).jpeg",
                                                 mimeType: "image/jpeg")
                    }
                }
            }, to: url, method: .post, headers: headers)
            .responseDecodable(of: RecipeBookUpoadModel.ImageUploadResponse.self) { response in
                debugPrint(response)
                guard let statusCode = response.response?.statusCode else { return }

                switch statusCode {
                case 200:
                    if let data = response.value {
                        print("이미지 업로드 성공")
                        completion(.success(data))
                    } else {
                        print("이미지 업로드 실패: \(response)")
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "이미지 업로드 실패"])))
                    }
                default:
                    print("이미지 업로드 실패: \(response)")
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "이미지 업로드 실패"])))
                }
            }
        } catch {
            print("Failed to get access token")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get access token"])))
        }
    }
    
    // MARK: - 레시피북 게시글 업로드
    func uploadPost(_ postModel: RecipeBookUpoadModel.RecipeRequest, completion: @escaping (Result<RecipeBookUpoadModel.RecipeResponseModel, Error>) -> Void) {
        let url = "\(baseURL)/recipes"
        
        do {
            let accessToken = try Keychain.shared.getToken(kind: .accessToken)
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(accessToken)",
                "Content-Type": "application/json"
            ]
            
            AF.request(url, method: .post, parameters: postModel, encoder: JSONParameterEncoder.default, headers: headers)
                .responseDecodable(of: RecipeBookUpoadModel.RecipeResponseModel.self) { response in
                    
                    switch response.result {
                            case .success(let data):
                                print("게시글 업로드 성공")
                                completion(.success(data))
                            case .failure:
                                if let data = response.data {
                                    let decoder = JSONDecoder()
                                    if let errorResponse = try? decoder.decode(ErrorResponseModel.self, from: data) {
                                        print("Server error response: \(errorResponse)")
                                    } else if let str = String(data: data, encoding: .utf8) {
                                        print("Server response: \(str)")
                                    }
                                }
                                
                                print("게시글 업로드 실패")
                                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "게시글 업로드 실패"])))
                            }
                        }
        } catch {
            print("Failed to get access token")
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to get access token"])))
        }
    }
}
