//
//  LinkerFirstViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit
import Then
import SnapKit

final class LinkerFirstViewController: UIViewController {
    
    var coordinator: LoginCoordinator?
    private let viewModel = SharedLinkerViewModel.shared
    
    private enum Strings {
        static let main = "뉴 링커님,\n어떻게 불리면 좋을까요?"
        static let sub = "이름을 입력해주세요"
    }
    
    private let titleLabel = UILabel().then {
        $0.text = Strings.main
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let textField = UnderlineTextField().then {
        $0.placeholder = Strings.sub
    }
    
    private let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#FF704D")
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        setupTextFieldObserver()
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
        view.addSubview(textField)
        view.addSubview(nextButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(158)
            make.leading.equalToSuperview().offset(26)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(43)
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
        nextButton.addTarget(self, action: #selector(nextTo), for: .touchUpInside)
    }
    
    // MARK: - 텍스트필드 입력 감지
    private func setupTextFieldObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldDidChange),
            name: UITextField.textDidChangeNotification,
            object: nil
        )
    }
    
    @objc
    private func textFieldDidChange() {
        guard let text = textField.text else { return }
        let hasText = !text.isEmpty
        
        nextButton.isEnabled = hasText
        UIView.animate(withDuration: 0.2) {
            self.nextButton.alpha = hasText ? 1.0 : 0.5
        }
    }
    
    @objc
    func nextTo() {
        guard let text = textField.text, !text.isEmpty else {
            showAlert(title: "입력 필요", message: "닉네임을 입력해주세요")
            return
        }
        viewModel.setNickname(text)
        Logger.d("저장된 닉네임: \(textField.text)")

        coordinator?.nextToLinkerSecond()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
