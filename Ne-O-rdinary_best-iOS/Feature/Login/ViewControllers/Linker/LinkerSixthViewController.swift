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
    private let viewModel = SharedLinkerViewModel.shared
    
    private var selectedCollaborationType: CollaborationType?
    private var selectedRegion: Region?
    
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
    
    private let regions: [Region] = [
        .seoul, .gyeonggi, .incheon, .daejeon, .sejong,
        .chungbuk, .chungnam, .gwangju, .jeonbuk, .jeonnam,
        .daegu, .gyeongbuk, .busan, .ulsan, .gyeongnam,
        .gangwon, .jeju, .anywhere
    ]
    
    private let dropView = CustomDropdown().then {
        $0.placeholder = "지역"
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
        $0.isEnabled = false
        $0.alpha = 0.5
    }
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        
        stackView.addArrangedSubview(onlineView)
        stackView.addArrangedSubview(offlineView)
        view.addSubview(stackView)
        
        // 지역 드롭다운 아이템 설정
        dropView.items = regions.map { $0.description }
        
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
        
        // 지역 선택 감지
        dropView.onSelectionChanged = { [weak self] selectedValue in
            self?.handleRegionSelection(selectedValue)
            self?.updateButtonState()
        }
    }
    
    @objc private func onlineTapped() {
        onlineView.toggleSelection(animated: true)
        offlineView.setSelected(false, animated: true)
        dropView.isHidden = true
        
        selectedCollaborationType = .online
        selectedRegion = nil  // 온라인일 경우 지역은 null
        updateButtonState()
    }
    
    @objc private func offlineTapped() {
        onlineView.setSelected(false, animated: true)
        offlineView.setSelected(true, animated: true)
        dropView.isHidden = false
        
        selectedCollaborationType = .offline
        updateButtonState()
    }
    
    // MARK: - 지역 선택 처리
    private func handleRegionSelection(_ selectedValue: String) {
        selectedRegion = regions.first { $0.description == selectedValue }
        Logger.d("선택된 지역: \(selectedRegion?.rawValue ?? "없음")")
    }
    
    // MARK: - 버튼 활성화/비활성화
    private func updateButtonState() {
        var isValid = false
        
        if let collaborationType = selectedCollaborationType {
            switch collaborationType {
            case .online:
                isValid = true
            case .offline:
                isValid = selectedRegion != nil
            case .both:
                isValid = selectedRegion != nil
            }
        }
        
        nextButton.isEnabled = isValid
        UIView.animate(withDuration: 0.2) {
            self.nextButton.alpha = isValid ? 1.0 : 0.5
        }
    }
    
    @objc private func nextButtonTap() {
        guard let selectedCollaborationType = selectedCollaborationType else {
            showAlert(title: "선택 필요", message: "협업 방식을 선택해주세요")
            return
        }
        
        if selectedCollaborationType == .offline {
            guard selectedRegion != nil else {
                showAlert(title: "선택 필요", message: "지역을 선택해주세요")
                return
            }
        }
        if let selectedRegion {
            viewModel.setRegion(selectedRegion.rawValue)
        } else {
            viewModel.setRegion("SEOUL")
        }
        viewModel.setCollaborationType(selectedCollaborationType.rawValue)
        
        if selectedCollaborationType == .online {
            Logger.d("협업 방식: \(selectedCollaborationType.rawValue), 지역: null")
        } else if let region = selectedRegion {
            viewModel.setRegion(region.rawValue)
            Logger.d("협업 방식: \(selectedCollaborationType.rawValue), 지역: \(region.rawValue)")
        }
        
        coordinator?.nextToLinkerSeventh()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
