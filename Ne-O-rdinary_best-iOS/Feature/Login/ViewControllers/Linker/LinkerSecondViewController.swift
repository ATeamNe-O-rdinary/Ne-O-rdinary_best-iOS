//
//  LinkerSecondViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit
import Then
import SnapKit

final class LinkerSecondViewController: UIViewController {
    
    var coordinator: LoginCoordinator?
    private let viewModel = SharedLinkerViewModel.shared
    
    private enum Strings {
        static let title = "뉴 링커님,\n어느 레벨로 소개해드리면 될까요?"
    }
    
    private let levels: [CareerLevel] = [.junior, .mid, .senior]
    private var selectedLevel: CareerLevel?
    
    private let titleLabel = UILabel().then {
        $0.text = Strings.title
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
    
    private let juniorView = SelectableBorderView().then {
        $0.borderWidth = 1
        $0.cornerRadius = 12
    }
    
    private let middleView = SelectableBorderView().then {
        $0.borderWidth = 1
        $0.cornerRadius = 12
    }
    
    private let seniorView = SelectableBorderView().then {
        $0.borderWidth = 1
        $0.cornerRadius = 12
    }
    
    private let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#FF704D")
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .medium)
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
        juniorView.setTitle(levels[0].description)
        middleView.setTitle(levels[1].description)
        seniorView.setTitle(levels[2].description)
        
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
        guard let selectedLevel = selectedLevel else {
//            showAlert(title: "선택 필요", message: "경력 레벨을 선택해주세요")
            return
        }
        
        // ViewModel에 데이터 저장
        viewModel.setCareerLevel(selectedLevel.rawValue)
        Logger.d("저장된 경력 레벨: \(selectedLevel.rawValue)")
        
        // 다음 화면으로 이동
        coordinator?.nextToLinkerThird()
    }
    
    @objc private func juniorViewTapped() {
        juniorView.toggleSelection(animated: true)
        middleView.setSelected(false, animated: true)
        seniorView.setSelected(false, animated: true)
        
        selectedLevel = .junior
        updateButtonState()
    }
    
    @objc private func middleViewTapped() {
        juniorView.setSelected(false, animated: true)
        middleView.setSelected(true, animated: true)
        seniorView.setSelected(false, animated: true)
        
        selectedLevel = .mid
        updateButtonState()
    }
    
    @objc private func seniorViewTapped() {
        juniorView.setSelected(false, animated: true)
        middleView.setSelected(false, animated: true)
        seniorView.setSelected(true, animated: true)
        
        selectedLevel = .senior
        updateButtonState()
    }
    
    // MARK: - 버튼 활성화/비활성화
    private func updateButtonState() {
        let isSelected = selectedLevel != nil
        nextButton.isEnabled = isSelected
        UIView.animate(withDuration: 0.2) {
            self.nextButton.alpha = isSelected ? 1.0 : 0.5
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
