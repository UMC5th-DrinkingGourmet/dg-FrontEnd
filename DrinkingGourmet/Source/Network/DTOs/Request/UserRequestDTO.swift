//
//  UserInfoDTO.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 7/1/24.
//

import Foundation

// 서버와 통신하기 위한 DTO
struct UserInfoDTO: Encodable {
    var name: String?
    var profileImage: String?
    var email: String?
    var nickName: String?
    var birthDate: String?
    var phoneNumber: String?
    var gender: String?
    var provider: String
    var providerId: String
    
    // 클라이언트 모델에서 DTO로 변환
    init(from userInfo: UserInfo) {
        self.name = userInfo.name
        self.profileImage = userInfo.profileImage
        self.email = userInfo.email
        self.nickName = userInfo.nickName
        self.birthDate = userInfo.birthDate
        self.phoneNumber = userInfo.phoneNumber
        self.gender = userInfo.gender
        self.provider = userInfo.provider
        self.providerId = userInfo.providerId
    }
}
