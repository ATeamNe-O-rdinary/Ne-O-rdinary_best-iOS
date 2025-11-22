//
//  WorkTimeType.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


enum WorkTimeType: String, Decodable {
    case weekend = "WEEKEND"
    case weekdayEvening = "WEEKDAY_EVENING"
    case anytime = "ANYTIME"
    
    var description: String {
        switch self {
        case .weekend: return "주말"
        case .weekdayEvening: return "평일 저녁"
        case .anytime: return "상시 가능"
        }
    }
}