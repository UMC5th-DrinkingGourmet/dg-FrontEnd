//
//  UserInfoDTO.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 7/1/24.
//

import Foundation

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
}
