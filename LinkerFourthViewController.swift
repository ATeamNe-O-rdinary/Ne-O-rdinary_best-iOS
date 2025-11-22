//
//  LinkerFourthViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit
import Then
import SnapKit

final class LinkerFourthViewController: UIViewController {
    
    var coordinator: LoginCoordinator?
    
    private enum Strings {
        static let title = "작업 가능 시간대를\n알려주세요"
        static let junior = "주말"
        static let middle = "당일 저녁"
        static let senior = "상시 가능"
    }
    
    private let titleLabel = UILabel().then {
        $0.text = Strings.title
        $0.font = UIFont.pretendard(size: 24, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    private let juniorView = SelectableBorderView().then {
        $0.borderWidth = 2
        $0.cornerRadius = 12
        $0.setTitle(Strings.junior)
    }
    
    private let middleView = SelectableBorderView().then {
        $0.borderWidth = 2
        $0.cornerRadius = 12
        $0.setTitle(Strings.middle)
    }
    
    private let seniorView = SelectableBorderView().then {
        $0.borderWidth = 2
        $0.cornerRadius = 12
        $0.setTitle(Strings.senior)
    }
    
    private let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#FF704D")
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
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
        
        stackView.addArrangedSubview(juniorView)
        stackView.addArrangedSubview(middleView)
        stackView.addArrangedSubview(seniorView)
        
        view.addSubview(stackView)
        view.addSubview(nextButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(158)
            make.leading.equalToSuperview().offset(26)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().inset(26)
            make.height.equalTo(172)
        }
        
        juniorView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        middleView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        seniorView.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().inset(26)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(52)
        }
    }
    
    func setupActions() {
        let juniorTap = UITapGestureRecognizer(target: self, action: #selector(juniorViewTapped))
        juniorView.addGestureRecognizer(juniorTap)
        
        let middleTap = UITapGestureRecognizer(target: self, action: #selector(middleViewTapped))
        middleView.addGestureRecognizer(middleTap)
        
        let seniorTap = UITapGestureRecognizer(target: self, action: #selector(seniorViewTapped))
        seniorView.addGestureRecognizer(seniorTap)
        
        nextButton.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
    }
    
    @objc private func nextButtonTap() {
        coordinator?.nextToLinkerThird()
    }
    
    @objc private func juniorViewTapped() {
        juniorView.toggleSelection(animated: true)
        middleView.setSelected(false, animated: true)
        seniorView.setSelected(false, animated: true)
    }
    
    @objc private func middleViewTapped() {
        juniorView.setSelected(false, animated: true)
        middleView.setSelected(true, animated: true)
        seniorView.setSelected(false, animated: true)
    }
    
    @objc private func seniorViewTapped() {
        juniorView.setSelected(false, animated: true)
        middleView.setSelected(false, animated: true)
        seniorView.setSelected(true, animated: true)
    }

}

