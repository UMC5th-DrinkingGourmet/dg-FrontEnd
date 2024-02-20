//
//  MyPageUserModel.swift
//  DrinkingGourmet
//
//  Created by 이승민 on 2/20/24.
//

struct MyPageUserModel: Codable {
    let isSuccess: Bool
    let code, message: String
    let result: Result
    
    struct Result: Codable {
        let memberId: Int
        let name, nickName, gender, birthDate: String
        let profileImageUrl: String
        let phoneNumber: String
    }
}
