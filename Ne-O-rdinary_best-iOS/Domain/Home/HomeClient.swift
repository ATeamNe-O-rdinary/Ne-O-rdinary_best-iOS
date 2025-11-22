//
//  ProfileAPI.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


enum LinkTingRole: String {
    case linker = "LINKER"
    case linko = "LINKO"
}

final class HomeClient {
    static let shared = HomeClient()
    private init() {}
    
    
    func fetchProfiles(
        type: ProfileType, // member / project
        category: CategoryOfBusiness = .appDev,
        rateUnit: RateUnit = .hourly,
        rateAmount: Int = 10000,
        role: LinkTingRole = .linker,
        page: Int = 0,
        size: Int = 10
    ) async throws -> [Any] {
        
        let params: [String: Any] = [
            "categoryOfBusiness": category.rawValue,
            "rateUnit": rateUnit.rawValue,
            "rateAmount": rateAmount,
            "linkTingRole": role.rawValue,
            "page": page,
            "size": size
        ]
        
        
        switch type {
            
        case .project:
            let res: ResultModel<ProjectPageData> = try await Networking.shared.sendRequest(
                "/api/members/profiles",
                resultType: ResultModel<ProjectPageData>.self,
                method: .get,
                parameters: params,
                headers: [
                  "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImlhdCI6MTc2Mzg1MDAzMywiZXhwIjoxNzY1MDU5NjMzfQ.QPYvEh8bfeK1G4TE_QKcYM9ueBttTzyFC7Ejpdu6ai0"
                ]
            )
            
            return res.data?.content ?? []
            
            
        case .member:
            let res: ResultModel<MemberPageData> = try await Networking.shared.sendRequest(
                "/api/members/profiles",
                resultType: ResultModel<MemberPageData>.self,
                method: .get,
                parameters: params,
                headers: [
                  "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImlhdCI6MTc2Mzg1MDAzMywiZXhwIjoxNzY1MDU5NjMzfQ.QPYvEh8bfeK1G4TE_QKcYM9ueBttTzyFC7Ejpdu6ai0"]
            )
            
            return res.data?.content ?? []
        }
    }
}
