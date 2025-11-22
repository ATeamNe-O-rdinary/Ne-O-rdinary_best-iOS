//
//  CategoryOfBusiness.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


enum CategoryOfBusiness: String, Decodable {
    case logoBranding = "LOGO_BRANDING"
    case webAppBanner = "WEB_APP_BANNER"
    case characterDesign = "CHARACTER_DESIGN"
    case packagePackaging = "PACKAGE_PACKAGING"
    case designETC = "DESIGN_ETC"
    
    case snsOperation = "SNS_OPERATION"
    case contentCreation = "CONTENT_CREATION"
    case performanceAD = "PERFORMANCE_AD"
    
    case webDev = "WEB_DEV"
    case appDev = "APP_DEV"
    case gameDev = "GAME_DEV"
    case aiDev = "AI_DEV"
    case serverSetup = "SERVER_SETUP"
    
    var description: String {
        switch self {
        case .logoBranding: return "로고/브랜딩"
        case .webAppBanner: return "웹/앱/배너"
        case .characterDesign: return "캐릭터 디자인"
        case .packagePackaging: return "패키지/포장"
        case .designETC: return "기타"
            
        case .snsOperation: return "SNS 운영"
        case .contentCreation: return "콘텐츠 제작"
        case .performanceAD: return "퍼포먼스 광고"
            
        case .webDev: return "웹 제작"
        case .appDev: return "앱 제작"
        case .gameDev: return "게임 개발"
        case .aiDev: return "AI"
        case .serverSetup: return "서버 구축"
        }
    }
    
    var mainCategory: MainCategory {
        switch self {
        case .logoBranding, .webAppBanner, .characterDesign, .packagePackaging, .designETC:
            return .design
            
        case .snsOperation, .contentCreation, .performanceAD:
            return .marketing
            
        case .webDev, .appDev, .gameDev, .aiDev, .serverSetup:
            return .itProgramming
        }
    }
}