//
//  ProjectProfile.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//

import Foundation

struct ProjectPageData: Decodable {
    let content: [ProjectProfile]
    let page: Int
    let size: Int
    let totalElements: Int
    let totalPages: Int
}

struct ProjectProfile: Decodable, Identifiable {
  var id: String { linkoId }   // ✔️ 서버의 고유값을 그대로 사용
    let linkoId: String
    let companyName: String
    let companyType: String
    let mainCategory: String
    let categoryOfBusiness: String
    let projectIntro: String
    let expectedDuration: String
    let rateUnit: String
    let rateAmount: Int
  let collaborationType: CollaborationType
    let region: String
    let deadline: String
  let techStacks: [TechStack]
    let profileImage: String
}
