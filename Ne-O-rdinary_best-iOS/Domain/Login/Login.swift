//
//  Login.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation

struct LoginResponseData: Codable {
    let username: String
    let isNewUser: Bool
    
    enum CodingKeys: String, CodingKey {
        case username
        case isNewUser = "isNewUser"
    }
}

struct LoginAPIResponse: Codable {
    let status: Int
    let code: String?
    let data: LoginResponseData
    let message: String
}
