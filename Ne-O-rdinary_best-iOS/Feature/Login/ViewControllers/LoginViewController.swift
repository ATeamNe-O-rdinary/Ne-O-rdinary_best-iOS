//
//  LoginViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/22/25.
//

import Foundation
import UIKit
import Then
import SnapKit
import KakaoSDKUser
import KakaoSDKCommon

class LoginViewController: UIViewController {
    
    private let kakaoLoginButton = UIButton().then {
        $0.setTitle("kakaoLogin", for: .normal)
        $0.backgroundColor = .systemYellow
        $0.setTitle("카카오 로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    @objc func kakaoLoginButtonTapped() {
        if UserApi.isKakaoTalkLoginAvailable() {
            loginWithKakaoTalk()
        } else {
            loginWithKakaoWeb()
        }
    }
    
    func setupUI() {
        view.addSubview(kakaoLoginButton)
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        kakaoLoginButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
}

extension LoginViewController {
    
    func loginWithKakaoTalk() {
        UserApi.shared.loginWithKakaoTalk { [weak self] oauthToken, error in
            if let error = error {
                Logger.e("카카오톡 로그인 실패: \(error)")
                //                  self?.showAlert(title: "로그인 실패", message: "카카오톡 로그인에 실패했습니다.")
            } else {
                Logger.d("카카오톡 로그인 성공")
                //                  self?.fetchUserInfo()
            }
        }
    }
    
    // MARK: - 카카오 웹 로그인
    func loginWithKakaoWeb() {
        UserApi.shared.loginWithKakaoAccount { [weak self] oauthToken, error in
            if let error = error {
                Logger.e("카카오 웹 로그인 실패: \(error)")
                //                  self?.showAlert(title: "로그인 실패", message: "카카오 웹 로그인에 실패했습니다.")
            } else {
                Logger.d("카카오 웹 로그인 성공")
                //                  self?.fetchUserInfo()
            }
        }
    }
}
