//
//  LoginViewModel.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit

class LoginViewModel {
    
    enum LoginState {
        case idle
        case loading
        case success(LoginResponseData)
        case failure(String)
    }
    
    var stateDidChange: ((LoginState) -> Void)?
    
    private(set) var state: LoginState = .idle {
        didSet {
            stateDidChange?(state)
        }
    }
    
    // MARK: - Methods
    func kakaoLogin() {
        guard let accessToken = UserStore.getAccessToken(),
              let refreshToken = UserStore.getRefreshToken() else {
            state = .failure("저장된 토큰이 없습니다")
            return
        }
        
        state = .loading
        
        Task {
            do {
                // 요청 파라미터
                let requestBody: [String: String] = [
                    "accessToken": accessToken,
                    "refreshToken": refreshToken
                ]
                
                let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
                let response = try await Networking.shared.sendRequestWithRaw(
                    "/api/v1/auth/kakao/login",
                    resultType: LoginAPIResponse.self,
                    method: .post,
                    rawBody: jsonData
                )
                
                await MainActor.run {
                    if response.status == 200 {
                        self.state = .success(response.data)
                        
                        if response.data.isNewUser {
                            Logger.d("새로운 사용자: 추가 정보 입력 필요")
                        }
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
    
    func reset() {
        state = .idle
    }
}
