//
//  RateUnit.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


enum RateUnit: String, Decodable {
    case hourly = "HOURLY"
    case perCase = "PER_CASE"
    case monthly = "MONTHLY"
    
    var description: String {
        switch self {
        case .hourly: return "시급"
        case .perCase: return "건수"
        case .monthly: return "월별"
        }
    }
}