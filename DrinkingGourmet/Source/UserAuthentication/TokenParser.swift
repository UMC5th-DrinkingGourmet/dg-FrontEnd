//
//  TokenParser.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 9/8/24.
//

import Foundation

class TokenParser {
    
    // payload 부분 추출
    static func parseJWT(_ token: String) -> [String: Any]? {
        let segments = token.split(separator: ".")
        guard segments.count == 3 else {
            return nil
        }
        
        let base64String = String(segments[1])
        let base64Padded = base64String.padding(toLength: ((base64String.count+3)/4)*4, withPad: "=", startingAt: 0)
        
        guard let decodedData = Data(base64Encoded: base64Padded, options: []) else {
            return nil
        }
        
        return try? JSONSerialization.jsonObject(with: decodedData, options: []) as? [String: Any]
    }
    
    // 토큰이 만료되었는지 확인(발급 시간만으로 유효성 추정, 10일로 설정)
    static func isTokenExpired(_ token: String, validForDays: Int = 10) -> Bool {
        guard let payload = parseJWT(token) else {
            return true
        }
        
        if let iat = payload["iat"] as? Double {
            let issuedDate = Date(timeIntervalSince1970: iat)
            
            // 10일 뒤 만료
            let expirationDate = Calendar.current.date(byAdding: .day, value: validForDays, to: issuedDate) ?? issuedDate
            
            return expirationDate <= Date()
        } else {
            return true
        }
    }
}
