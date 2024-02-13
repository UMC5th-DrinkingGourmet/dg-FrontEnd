//
//  KeyChain.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 2/11/24.
//

import Security
import Foundation

enum KeyChainError: Error {
    case noData
    case unexpectedData
    case unhandledError(status: OSStatus)
}

class Keychain {
    static let shared = Keychain()
    
    enum TokenKind: String {
        case accessToken = "Authorization"
        case refreshToken = "RefreshToken"
    }
    
    private init() { }
    
    func saveToken(kind: TokenKind, token: String) {
        guard let data = token.data(using: .utf8) else { return }

        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : kind.rawValue,
            kSecValueData as String   : data ] as [String : Any]
        
        // 기존에 있던 건 업데이트
        let status = SecItemUpdate(query as CFDictionary, [kSecValueData as String: data] as CFDictionary)

        if status == errSecItemNotFound {
            // 기존에 없던 건 추가
            SecItemAdd(query as CFDictionary, nil)
        } else if status != errSecSuccess {
            print("Failed to save token: \(status)")
        }
    }

    
    func getToken(kind: TokenKind) throws -> String {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : kind.rawValue,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status != errSecItemNotFound else { throw KeyChainError.noData }
        guard status == errSecSuccess else { throw KeyChainError.unhandledError(status: status) }
        
        guard let data = dataTypeRef as? Data, let token = String(data: data, encoding: .utf8) else {
            throw KeyChainError.unexpectedData
        }
        
        return token
    }
    
    func deleteToken(kind: TokenKind) throws {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : kind.rawValue
        ] as [String : Any]

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeyChainError.unhandledError(status: status) }
    }
}
