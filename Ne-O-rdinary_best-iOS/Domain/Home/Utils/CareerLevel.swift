//
//  CareerLevel.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


enum CareerLevel: String, Decodable {
    case junior = "JUNIOR"
    case mid = "MID"
    case senior = "SENIOR"
    
    var description: String {
        switch self {
        case .junior: return "초급 (1년 이하)"
        case .mid: return "중급 (1~3년)"
        case .senior: return "시니어 (3년 이상)"
        }
    }
}