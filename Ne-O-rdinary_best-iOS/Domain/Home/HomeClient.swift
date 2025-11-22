//
//  ProfileAPI.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


final class HomeClient {
  static let shared = HomeClient()
  private init() {}
  
  func fetchProfiles(
    //       filter: ProfileFilterRequest,
    page: Int = 0,
    size: Int = 10,
    type: ProfileType
  ) async throws -> [Any] {
    
    let params: [String: Any] = [
      "categoryOfBusiness": "로고/브랜딩",
      "minSalary": 3000,
      "maxSalary": 8000,
      "page": page,
      "size": size
    ]
    
    switch type {
      
    case .project:
      let res: ResultModel<ProjectPageData> =
      try await Networking.shared.sendRequest(
        "/api/members/profiles",
        resultType: ResultModel<ProjectPageData>.self,
        method: .get,
        parameters: params,
        headers: [
            "Authorization": "Bearer \("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImlhdCI6MTc2MzgzNzg1NywiZXhwIjoxNzYzODQxNDU3fQ.PNhIPmuyzYzyOLpAYRmctiuZOih4sWQssoDrzT8G3x4")"
        ]
      )
      
      return res.data?.content ?? []
      
    case .member:
      let res: ResultModel<MemberPageData> =
      try await Networking.shared.sendRequest(
        "/api/members/profiles",
        resultType: ResultModel<MemberPageData>.self,
        method: .get,
        parameters: params,
        headers: [
            "Authorization": "Bearer \("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImlhdCI6MTc2MzgzNzg1NywiZXhwIjoxNzYzODQxNDU3fQ.PNhIPmuyzYzyOLpAYRmctiuZOih4sWQssoDrzT8G3x4")"
        ]
      )
      
      return res.data?.content ?? []
    }
  }
}
