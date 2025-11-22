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

struct ProjectProfile: Decodable {
    let linkoId: String
    let companyName: String
    let companyType: String
    let mainCategory: String
    let categoryOfBusiness: String
    let projectIntro: String
    let expectedDuration: String
    let rateUnit: String
    let rateAmount: Int
    let collaborationType: String
    let region: String
    let deadline: String
    let techStacks: [String]
    let profileImage: String
}
