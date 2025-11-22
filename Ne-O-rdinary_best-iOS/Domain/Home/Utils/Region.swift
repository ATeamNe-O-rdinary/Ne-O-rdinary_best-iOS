//
//  Region.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


enum Region: String, Decodable {
    case seoul = "SEOUL"
    case gyeonggi = "GYEONGGI"
    case incheon = "INCHEON"
    case daejeon = "DAEJEON"
    case sejong = "SEJONG"
    case chungbuk = "CHUNGBUK"
    case chungnam = "CHUNGNAM"
    case gwangju = "GWANGJU"
    case jeonbuk = "JEONBUK"
    case jeonnam = "JEONNAM"
    case daegu = "DAEGU"
    case gyeongbuk = "GYEONGBUK"
    case busan = "BUSAN"
    case ulsan = "ULSAN"
    case gyeongnam = "GYEONGNAM"
    case gangwon = "GANGWON"
    case jeju = "JEJU"
    case anywhere = "ANYWHERE"
    
    var description: String {
        switch self {
        case .seoul: return "서울"
        case .gyeonggi: return "경기"
        case .incheon: return "인천"
        case .daejeon: return "대전"
        case .sejong: return "세종"
        case .chungbuk: return "충북"
        case .chungnam: return "충남"
        case .gwangju: return "광주"
        case .jeonbuk: return "전북"
        case .jeonnam: return "전남"
        case .daegu: return "대구"
        case .gyeongbuk: return "경북"
        case .busan: return "부산"
        case .ulsan: return "울산"
        case .gyeongnam: return "경남"
        case .gangwon: return "강원"
        case .jeju: return "제주"
        case .anywhere: return "전국 무관"
        }
    }
}