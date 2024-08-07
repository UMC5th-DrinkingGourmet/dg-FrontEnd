//
//  File.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 7/17/24.
//

import Foundation

struct UserStatusResponse: Decodable {
    var isSuccess: Bool
    var code: String
    var message: String
    var result: UserStatus
}

struct UserStatus: Decodable {
    var provider: String
    var nickName: String
    var memberId: Int
    var newMember: Bool
    var createdAt: String
}

struct UserDivisionResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UserDivisionResult
}

struct UserDivisionResult: Decodable {
    let isSignedUp: Bool
}
