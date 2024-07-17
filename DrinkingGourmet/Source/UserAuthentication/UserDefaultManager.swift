//
//  UserDefaultManager.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/5/24.
//

import Foundation

class UserDefaultManager {
    private init() {
        
    }
    
    static let shared = UserDefaultManager()
    
    enum UDKey: String {
        case userId
        case userName
        case userBirth
        case userPhoneNumber
        case userProfileImg
        case userGender
        case userNickname
        case email
        case provider
        case providerId
    }
    
    let ud = UserDefaults.standard
    
    var userId: String {
        get {
            ud.string(forKey: UDKey.userId.rawValue) ?? "-1"
        }
        set {
            ud.setValue(newValue, forKey: UDKey.userId.rawValue)
        }
    }
    
    var userName: String {
        get {
            ud.string(forKey: UDKey.userName.rawValue) ?? "profile1"
        }
        set {
            ud.setValue(newValue, forKey: UDKey.userName.rawValue)
        }
    }
    
    var userBirth: String {
        get {
            ud.string(forKey: UDKey.userBirth.rawValue) ?? ""
        }
        set {
            ud.setValue(newValue, forKey: UDKey.userBirth.rawValue)
        }
    }
    
    var userPhoneNumber: String {
        get {
            ud.string(forKey: UDKey.userPhoneNumber.rawValue) ?? ""
        }
        set {
            ud.setValue(newValue, forKey: UDKey.userPhoneNumber.rawValue)
        }
    }
    
    var userProfileImg: String {
        get {
            ud.string(forKey: UDKey.userProfileImg.rawValue) ?? ""
        }
        set {
            ud.setValue(newValue, forKey: UDKey.userProfileImg.rawValue)
        }
    }
    
    var userGender: String {
        get {
            ud.string(forKey: UDKey.userGender.rawValue) ?? ""
        }
        set {
            ud.setValue(newValue, forKey: UDKey.userGender.rawValue)
        }
    }
    
    var userNickname: String {
        get {
            ud.string(forKey: UDKey.userNickname.rawValue) ?? ""
        }
        set {
            ud.setValue(newValue, forKey: UDKey.userNickname.rawValue)
        }
    }
    
    var email: String {
        get {
            ud.string(forKey: UDKey.email.rawValue) ?? ""
        }
        set {
            ud.setValue(newValue, forKey: UDKey.email.rawValue)
        }
    }
    
    var provider: String {
        get {
            ud.string(forKey: UDKey.provider.rawValue) ?? ""
        }
        set {
            ud.setValue(newValue, forKey: UDKey.provider.rawValue)
        }
    }
    
    var providerId: String {
        get {
            ud.string(forKey: UDKey.providerId.rawValue) ?? ""
        }
        set {
            ud.setValue(newValue, forKey: UDKey.providerId.rawValue)
        }
    }
}
