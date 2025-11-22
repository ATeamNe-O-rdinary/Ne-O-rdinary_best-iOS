//
//  MemberProfile.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//

import Foundation

struct MemberPageData: Decodable {
  let content: [MemberProfile]
  let page: Int
  let size: Int
  let totalElements: Int
  let totalPages: Int
}

struct MemberProfile: Decodable, Identifiable {
  var id: String { linkerId }   // ✔️ 서버의 고유값을 그대로 사용
  let linkerId: String
  let nickname: String
  let careerLevel: CareerLevel
  let workTimeType: WorkTimeType
  let rateUnit: RateUnit
  let collaborationType: CollaborationType
  let region: Region
  let techStacks: [TechStack]
  let categoryOfBusiness: CategoryOfBusiness
  let jobCategory: String
  let oneLineDescription: String
  let rateAmount: Int
  let profileImage: String
}
