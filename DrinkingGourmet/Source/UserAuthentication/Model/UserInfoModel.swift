//
//  UserInfoInput.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/7/24.
//

struct UserInfoModel: Encodable {
    var name: String
    var profileImage: String
    var email: String
    var nickName: String
    var birthDate: String
    var phoneNumber: String
    var gender: String
    var provider: String
    var providerId: String
}
