//
//  CollaborationType.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


enum CollaborationType: String, Decodable {
    case online = "ONLINE"
    case offline = "OFFLINE"
    case both = "BOTH"
    
    var description: String {
        switch self {
        case .online: return "온라인"
        case .offline: return "오프라인"
        case .both: return "온라인/오프라인"
        }
    }
}