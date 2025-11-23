//
//  LinkerFifthViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit
import Then
import SnapKit

final class LinkerFifthViewController: UIViewController {
    
    var coordinator: LoginCoordinator?
    private let viewModel = SharedLinkerViewModel.shared
    
    private var selectedRateUnit: RateUnit?
    
    private enum Strings {
        static let main = "희망하시는\n단가 범위를 알려주세요"
        static let sub = "시급/건별/월 단가 중 원하는 범위를 선택해주세요"
        static let placeholder = "비용을 입력해주세요"
    }
    
    private let titleLabel = UILabel().then {
        $0.text = Strings.main
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = Strings.sub
        $0.font = UIFont.pretendard(size: 14, weight: .medium)
        $0.textColor = UIColor(hexString: "#76797D")
        $0.numberOfLines = 2
    }
    
    private let dropView = CustomDropdown().then {
        $0.placeholder = "구분"
        $0.items = ["시급", "건수", "월별"]
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hexString: "#EAECEE").cgColor
        $0.layer.cornerRadius = 12
    }
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 8
    }
    
    private let textField = UnderlineNumberTextField().then {
        $0.placeholder = Strings.placeholder
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
        setupObservers()
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
      tapGesture.cancelsTouchesInView = false
      view.addGestureRecognizer(tapGesture)
    }
    
  @objc
  private func dismissKeyboard() {
      view.endEditing(true)
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        stackView.addArrangedSubview(dropView)
        stackView.addArrangedSubview(textField)
        
        view.addSubview(stackView)
        view.addSubview(nextButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(158)
            make.leading.equalToSuperview().offset(26)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(26)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(34)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().inset(26)
            make.height.equalTo(52)
        }
        
        dropView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(78)
        }
        
        textField.snp.makeConstraints { make in
            make.height.equalToSuperview()
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
        
        dropView.onSelectionChanged = { [weak self] selectedValue in
            self?.handleRateUnitSelection(selectedValue)
            self?.updateButtonState()
        }
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldDidChange),
            name: UITextField.textDidChangeNotification,
            object: nil
        )
    }
    
    @objc
    private func textFieldDidChange() {
        updateButtonState()
    }
    
    // MARK: - 레이트 단위 선택 처리
    private func handleRateUnitSelection(_ selectedValue: String) {
        switch selectedValue {
        case "시급":
            selectedRateUnit = .hourly
        case "건수":
            selectedRateUnit = .perCase
        case "월별":
            selectedRateUnit = .monthly
        default:
            selectedRateUnit = nil
        }
        
        Logger.d("선택된 단가 유형: \(selectedRateUnit?.rawValue ?? "없음")")
    }
    
    // MARK: - 버튼 활성화/비활성화
    private func updateButtonState() {
        guard let text = textField.text else { return }
        let hasUnit = selectedRateUnit != nil
        let hasAmount = !text.isEmpty
        let isValid = hasUnit && hasAmount
        
        nextButton.isEnabled = isValid
        UIView.animate(withDuration: 0.2) {
            self.nextButton.alpha = isValid ? 1.0 : 0.5
        }
    }
    
    @objc
    func nextTo() {
        guard let selectedRateUnit = selectedRateUnit else {
            showAlert(title: "선택 필요", message: "단가 유형을 선택해주세요")
            return
        }
        
        guard let amountText = textField.text, !amountText.isEmpty,
              let amount = Int(amountText) else {
            showAlert(title: "입력 필요", message: "유효한 금액을 입력해주세요")
            return
        }
        
        viewModel.setRateInfo(unit: selectedRateUnit.rawValue, amount: amount)
        Logger.d("저장된 단가: \(selectedRateUnit.rawValue) - \(amount)")
        
        coordinator?.nextToLinkerSixth()
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

class UnderlineNumberTextField: UIView, UITextFieldDelegate {
    
    private let textField = UITextField().then {
        $0.borderStyle = .none
        $0.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.textColor = .black
      $0.keyboardType = .numberPad        // 🔥 숫자 전용 키보드

    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = UIColor(hexString: "#FF704D")
    }
    
    var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var text: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    var inactiveLineColor: UIColor = UIColor(hexString: "#EAECEE") {
        didSet {
            if !textField.isFirstResponder {
                underlineView.backgroundColor = inactiveLineColor
            }
        }
    }
    
    var activeLineColor: UIColor = UIColor(hexString: "#FF704D") {
        didSet {
            if textField.isFirstResponder {
                underlineView.backgroundColor = activeLineColor
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup
    private func setupUI() {
        addSubview(textField)
        addSubview(underlineView)
        
        textField.delegate = self
        
        textField.addTarget(self, action: #selector(textDidBeginEditing), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textDidEndEditing), for: .editingDidEnd)
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(43)
        }
        
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    // MARK: - Actions
    @objc private func textDidBeginEditing() {
        UIView.animate(withDuration: 0.2) {
            self.underlineView.backgroundColor = self.activeLineColor
        }
    }
    
    @objc private func textDidEndEditing() {
        UIView.animate(withDuration: 0.2) {
            self.underlineView.backgroundColor = self.inactiveLineColor
        }
    }
}
