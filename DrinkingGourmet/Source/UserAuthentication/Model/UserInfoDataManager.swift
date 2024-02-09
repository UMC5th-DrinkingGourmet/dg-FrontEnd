//
//  UserInfoDataManager.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/9/24.
//

import Alamofire

class UserInfoDataManager {
    static let shared = UserInfoDataManager()
    
    private init() { }
    
    func sendUserInfo(_ parameter: UserInfoModel) {
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]
            
            AF.request("https://drink-gourmet.kro.kr/auth/kakao",
                       method: .post,
                       parameters: parameter,
                       encoder: JSONParameterEncoder.default,
                       headers: headers)
                .validate()
                .response { response in
                    switch response.result {
                    case .success:
                        print("Request Successful")
                    case .failure(let failure):
                        print("Request Failed: \(failure)")
                    }
                }
        }
}

