//
//  LinkerInformViewModel.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit
import Alamofire

class SharedLinkerViewModel: NSObject {
    
    enum SubmitState {
        case idle
        case loading
        case success
        case failure(String)
    }
    
    var stateDidChange: ((SubmitState) -> Void)?
    
    private(set) var state: SubmitState = .idle {
        didSet {
            stateDidChange?(state)
        }
    }
    
    static let shared = SharedLinkerViewModel()
    
    private(set) var userData = LinkerUserData()
    
    func setNickname(_ nickname: String) {
        userData.nickname = nickname
        Logger.d("Nickname 저장: \(nickname)")
    }
    
    func setJobCategory(_ category: String) {
        userData.jobCategory = category
        Logger.d("JobCategory 저장: \(category)")
    }
    
    func setCareerLevel(_ level: String) {
        userData.careerLevel = level
        Logger.d("CareerLevel 저장: \(level)")
    }
    
    func setOneLineDescription(_ description: String) {
        userData.oneLineDescription = description
        Logger.d("OneLineDescription 저장: \(description)")
    }
    
    func setWorkTimeType(_ type: String) {
        userData.workTimeType = type
        Logger.d("WorkTimeType 저장: \(type)")
    }
    
    func setRateInfo(unit: String, amount: Int) {
        userData.rateUnit = unit
        userData.rateAmount = amount
        Logger.d("Rate 저장: \(unit) - \(amount)")
    }
    
    func setCollaborationType(_ type: String) {
        userData.collaborationType = type
        Logger.d("CollaborationType 저장: \(type)")
    }
    
    func setRegion(_ region: String) {
        userData.region = region
        Logger.d("Region 저장: \(region)")
    }
    
    func setTechStacks(_ stacks: [String]) {
        userData.techStacks = stacks
        Logger.d("TechStacks 저장: \(stacks)")
    }
    
    // MARK: - 데이터 조회
    func getUserData() -> LinkerUserData {
        return userData
    }
    
    func isDataValid() -> Bool {
        return !(userData.nickname?.isEmpty ?? true) &&
               userData.careerLevel != nil &&
               !(userData.oneLineDescription?.isEmpty ?? true) &&
               userData.workTimeType != nil &&
               userData.rateUnit != nil &&
               userData.rateAmount != nil &&
               userData.collaborationType != nil &&
               !userData.techStacks.isEmpty
    }
    
    // MARK: - 데이터 전송
    func submitUserData() {
        Logger.d("\(userData)")
        guard isDataValid() else {
            state = .failure("필수 정보를 모두 입력해주세요")
            return
        }
        
        state = .loading
        
        Task {
            do {
//                guard let accessToken = UserStore.getAccessToken() else {
//                    state = .failure("토큰이 없습니다")
//                    return
//                }
                let accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImlhdCI6MTc2Mzg1MDAzMywiZXhwIjoxNzY1MDU5NjMzfQ.QPYvEh8bfeK1G4TE_QKcYM9ueBttTzyFC7Ejpdu6ai0"
                let jsonData = try JSONEncoder().encode(userData)
                
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    Logger.d("요청 데이터: \(jsonString)")
                }
                
                let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(accessToken)",
                    "Content-Type": "application/json"
                ]
                
                let response = try await Networking.shared.sendRequestWithRaw(
                    "/api/v1/linkers",
                    resultType: RegisterAPIResponse.self,
                    method: .post,
                    rawBody: jsonData,
                    headers: headers
                )
                
                await MainActor.run {
                    if response.status == 200 || response.status == 201 {
                        self.state = .success
                        Logger.d("링커 등록 성공")
                        Logger.d("링커 ID: \(response.data?.id ?? 0)")
                        Logger.d("닉네임: \(response.data?.nickname ?? "")")
                        self.reset()
                    } else {
                        self.state = .failure(response.message)
                    }
                }
                
            } catch {
                await MainActor.run {
                    Logger.e("API Error: \(error.localizedDescription)")
                    self.state = .failure(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - 초기화
    func reset() {
        userData = LinkerUserData()
        state = .idle
    }
}
