//
//  LinkerSixthViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit
import Then
import SnapKit

final class LinkerSixthViewController: UIViewController {
    
    var coordinator: LoginCoordinator?
    
    private enum Strings {
        static let title = "온라인/오프라인\n어떤 협업을 원하시나요?"
        static let online = "온라인"
        static let offline = "오프라인"
    }
    
    private let titleLabel = UILabel().then {
        $0.text = Strings.title
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
    
    private let onlineView = SelectableBorderView().then {
        $0.borderWidth = 1
        $0.cornerRadius = 12
        $0.setTitle(Strings.online)
    }
    
    private let offlineView = SelectableBorderView().then {
        $0.borderWidth = 1
        $0.cornerRadius = 12
        $0.setTitle(Strings.offline)
    }
    
    private let dropView = CustomDropdown().then {
        $0.placeholder = "지역"
        let regions: [String] = [
            "서울",
            "경기",
            "인천",
            "대전",
            "세종",
            "충남",
            "충북",
            "광주",
            "전남",
            "전북",
            "대구",
            "경북",
            "부산",
            "울산",
            "경남",
            "강원",
            "제주",
            "전국 무관"
        ]
        $0.items = regions
        $0.onSelectionChanged = { selectedValue in
            Logger.d("선택: \(selectedValue)")
        }
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hexString: "#EAECEE").cgColor
        $0.layer.cornerRadius = 12
        $0.isHidden = true
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
        
        stackView.addArrangedSubview(onlineView)
        stackView.addArrangedSubview(offlineView)
        view.addSubview(stackView)
        
        view.addSubview(dropView)
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
            make.height.equalTo(52)
        }
        
        onlineView.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        offlineView.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        dropView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().inset(26)
            make.height.equalTo(52)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().inset(26)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(52)
        }
    }
    
    func setupActions() {
        let onlineTap = UITapGestureRecognizer(target: self, action: #selector(onlineTapped))
        onlineView.addGestureRecognizer(onlineTap)
        
        let offlineTap = UITapGestureRecognizer(target: self, action: #selector(offlineTapped))
        offlineView.addGestureRecognizer(offlineTap)
        
        nextButton.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
    }
    
    @objc private func nextButtonTap() {
        coordinator?.nextToLinkerSeventh()
    }
    
    @objc private func onlineTapped() {
        onlineView.toggleSelection(animated: true)
        offlineView.setSelected(false, animated: true)
        dropView.isHidden = true
    }
    
    @objc private func offlineTapped() {
        onlineView.setSelected(false, animated: true)
        offlineView.setSelected(true, animated: true)
        dropView.isHidden = false
    }
}
