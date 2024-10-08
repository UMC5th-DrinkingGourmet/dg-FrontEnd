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
            print("JWT 토큰이 유효하지 않음: 세그먼트 개수 = \(segments.count)")
            return nil
        }

        let base64String = String(segments[1])
        let base64Padded = base64String.padding(toLength: ((base64String.count+3)/4)*4, withPad: "=", startingAt: 0)

        guard let decodedData = Data(base64Encoded: base64Padded, options: []) else {
            print("JWT 토큰의 페이로드 부분을 Base64로 디코딩하는 데 실패")
            return nil
        }

        do {
            if let payload = try JSONSerialization.jsonObject(with: decodedData, options: []) as? [String: Any] {
                print("JWT 페이로드 추출 성공: \(payload)")
                return payload
            } else {
                print("페이로드가 유효한 JSON 객체가 아님")
                return nil
            }
        } catch {
            print("JWT 페이로드를 JSON으로 변환하는 중 오류 발생: \(error)")
            return nil
        }
    }

    static func isTokenExpired(_ token: String) -> Bool {
        guard let payload = parseJWT(token) else {
            print("페이로드를 파싱할 수 없어 만료로 간주")
            return true
        }

        if let exp = payload["exp"] as? Double {
            let expirationDate = Date(timeIntervalSince1970: exp)
            print("JWT 만료 시간: \(expirationDate), 현재 시간: \(Date())")
            return expirationDate <= Date()
        } else {
            print("JWT에 만료 시간(exp) 정보가 없음")
            return true
        }
    }
}
