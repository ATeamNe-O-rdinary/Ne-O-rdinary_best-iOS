//
//  LoginSelect1ViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit
import Then
import SnapKit

final class LoginSelect1ViewController: UIViewController {
    
    private enum Strings {
        static let company = "기업"
        static let person = "개인"
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "당신의\n정보를 알려주세요"
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    private let companyView = SelectableBorderView().then {
        $0.borderWidth = 1
        $0.cornerRadius = 12
        $0.setTitle(Strings.company)
    }
    
    private let personView = SelectableBorderView().then {
        $0.borderWidth = 1
        $0.cornerRadius = 12
        $0.setTitle(Strings.person)
    }
    
    var coordinator: LoginCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        
        stackView.addArrangedSubview(companyView)
        stackView.addArrangedSubview(personView)
        
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(148)
            make.leading.equalToSuperview().offset(26)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().inset(26)
            make.height.equalTo(112)
        }
        
        companyView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        personView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
    func setupActions() {
        let companyTap = UITapGestureRecognizer(target: self, action: #selector(companyViewTapped))
        companyView.addGestureRecognizer(companyTap)
        
        let personTap = UITapGestureRecognizer(target: self, action: #selector(personViewTapped))
        personView.addGestureRecognizer(personTap)
    }
    
    @objc private func companyViewTapped() {
        companyView.toggleSelection(animated: true)
        personView.setSelected(false, animated: true)
    }
    
    @objc private func personViewTapped() {
        personView.toggleSelection(animated: true)
        companyView.setSelected(false, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [unowned self] in
            self.coordinator?.nextToLinkerFirst()
        }
    }
}
