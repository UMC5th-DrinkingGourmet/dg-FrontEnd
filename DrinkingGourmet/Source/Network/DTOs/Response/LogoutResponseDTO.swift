//
//  LogoutResponseDTO.swift
//  DrinkingGourmet
//
//  Created by hwijinjeong on 8/11/24.
//

import Foundation

struct LogoutResponseDTO: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String
}
