//
//  UserInform.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit

struct LinkerUserData: Codable {
    var nickname: String?
    var jobCategory: String = "SNS_OPERATION"
    var careerLevel: String?
    var oneLineDescription: String?
    var workTimeType: String?
    var rateUnit: String?
    var rateAmount: Int?
    var collaborationType: String?
    var region: String?
    var techStacks: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case nickname
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
