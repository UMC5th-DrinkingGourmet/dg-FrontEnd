//
//  File.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 7/17/24.
//

import Foundation

struct UserStatusResponseDTO: Decodable {
    var isSuccess: Bool
    var code: String
    var message: String
    var result: UserStatusDTO
}

// 서버에서 오는 응답에 대한 DTO
struct UserStatusDTO: Decodable {
    var provider: String
    var nickName: String
    var memberId: Int
    var newMember: Bool
    var createdAt: String
    
    // DTO를 클라이언트 모델로 변환
    func toDomain() -> UserStatus {
        return UserStatus(
            provider: self.provider,
            nickName: self.nickName,
            memberId: self.memberId,
            newMember: self.newMember,
            createdAt: self.createdAt
        )
    }
}

struct UserDivisionResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UserDivisionResultDTO

    // 클라이언트 모델로 변환
    func toDomain() -> UserDivision {
        return UserDivision(isSignedUp: self.result.isSignedUp)
    }
}

struct UserDivisionResultDTO: Decodable {
    let isSignedUp: Bool
}
