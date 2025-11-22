//
//  LinkerResponseData.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation

struct LinkerResponseData: Codable {
    let id: Int
    let memberId: Int
    let nickname: String
    let mainCategory: String
    let jobCategory: String
    let careerLevel: String
    let oneLineDescription: String
    let workTimeType: String
    let rateUnit: String
    let rateAmount: Int
    let collaborationType: String
    let region: String
    let techStacks: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case memberId
        case nickname
        case mainCategory
        case jobCategory
        case careerLevel
        case oneLineDescription
        case workTimeType
        case rateUnit
        case rateAmount
        case collaborationType
        case region
        case techStacks
    }
}

struct RegisterAPIResponse: Codable {
    let status: Int
    let code: String?
    let data: LinkerResponseData?
    let message: String
}
