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
    
    private let titleLabel = UILabel().then {
        $0.text = "링크팅에\n오신 것을 환영합니다!"
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let imageView = UIImageView().then {
        $0.image = R.Images.$snsTipView
        $0.contentMode = .scaleAspectFill
    }
    
    var coordinator: LoginCoordinator?
    
    private let kakaoLoginButton = UIButton().then {
        $0.backgroundColor = .systemYellow
        $0.setTitle("카카오로 시작하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.setImage(R.Images.$kakao, for: .normal)
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        $0.contentHorizontalAlignment = .center
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
//        coordinator?.nextToPage1()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(kakaoLoginButton)
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(177)
            make.leading.equalToSuperview().offset(26)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().inset(26)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(52)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(kakaoLoginButton.snp.top).offset(-17)
            make.width.equalTo(170)
            make.height.equalTo(42)
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
                if let refreshToken = oauthToken?.refreshToken {
                    
                }
                
                
                Logger.d("\(oauthToken?.accessToken)")
                Logger.d("\(oauthToken?.refreshToken)")
                //                  self?.fetchUserInfo()
            }
        }
    }
}
