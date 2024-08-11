//
//  User+Mapping.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 8/11/24.
//

//import Foundation
//
//extension User {
//    init(from responseDTO: UserStatusDTO) {
//        self.provider = responseDTO.provider
//        self.nickName = responseDTO.nickName
//        self.memberId = responseDTO.memberId
//        self.isNewMember = responseDTO.newMember
//        self.createdAt = responseDTO.createdAt
//        
//        self.name = UserDefaultManager.shared.userName
//        self.profileImage = UserDefaultManager.shared.userProfileImg
//        self.email = UserDefaultManager.shared.email
//        self.birthDate = UserDefaultManager.shared.userBirth
//        self.phoneNumber = UserDefaultManager.shared.userPhoneNumber
//        self.gender = UserDefaultManager.shared.userGender
//        self.providerId = UserDefaultManager.shared.providerId
//    }
//    
//    func toRequestDTO() -> UserRequestDTO {
//        return UserRequestDTO(
//            name: self.name,
//            profileImage: self.profileImage,
//            email: self.email,
//            nickName: self.nickName,
//            birthDate: self.birthDate,
//            phoneNumber: self.phoneNumber,
//            gender: self.gender,
//            provider: self.provider,
//            providerId: self.providerId
//        )
//    }
//}
