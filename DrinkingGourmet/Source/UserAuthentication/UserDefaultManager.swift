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
        case userName
        case userBirth
        case userPhoneNumber
        case userProfileImg
        case userGender
        case userNickname
    }
    
    let ud = UserDefaults.standard
    
    var userName: String {
        get {   // 선택한 이미지를 불러온다
            ud.string(forKey: UDKey.userName.rawValue) ?? "profile1"
        }
        set {   // 선택한 이미지를 저장한다
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
    

    func removeAll() {

    }
}
