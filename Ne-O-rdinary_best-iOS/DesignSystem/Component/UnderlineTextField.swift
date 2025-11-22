//
//  UnderLineTextField.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import UIKit
import Then
import SnapKit

class UnderlineTextField: UIView {
    
    private let textField = UITextField().then {
        $0.borderStyle = .none
        $0.font = UIFont.pretendard(size: 16, weight: .medium)
        $0.textColor = .black
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

// MARK: - UITextFieldDelegate
extension UnderlineTextField: UITextFieldDelegate {
    func textField(_ UITextField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 한 줄만 입력 (줄바꿈 불가)
        return !string.contains("\n")
    }
}
