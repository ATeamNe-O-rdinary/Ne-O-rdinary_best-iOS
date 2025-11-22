//
//  MainCategory.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


enum MainCategory: String, Decodable {
    case design = "DESIGN"
    case marketing = "MARKETING"
    case itProgramming = "IT_PROGRAMMING"
    
    var description: String {
        switch self {
        case .design: return "디자인"
        case .marketing: return "마케팅"
        case .itProgramming: return "IT/프로그래밍"
        }
    }
}