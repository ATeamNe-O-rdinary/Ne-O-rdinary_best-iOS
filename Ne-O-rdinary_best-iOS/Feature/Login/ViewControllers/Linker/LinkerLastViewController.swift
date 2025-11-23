//
//  LinkerLastViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit
import Then
import SnapKit

final class LinkerLastViewController: UIViewController {
    
    var coordinator: LoginCoordinator?
    
    private enum Strings {
        static let title = "당신의 링커 카드가 완성되었어요!"
        static let home = "홈으로"
    }
    
    private let titleLabel = UILabel().then {
        $0.text = Strings.title
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let imageView = UIImageView().then {
        $0.image = R.Images.$cardImage
         $0.contentMode = .scaleAspectFit
     }
    
    private let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#FF704D")
        $0.setTitle(Strings.home, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(nextButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(158)
            make.leading.equalToSuperview().offset(26)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.width.equalTo(323)
            make.height.equalTo(424)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().inset(26)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(52)
        }
    }
    
    func setupActions() {
        nextButton.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
    }
    
    @objc private func nextButtonTap() {
        coordinator?.finishLogin()
    }
}
