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
    
    private enum Strings {
        static let main = "희망하시는\n단가 범위를 알려주세요"
        static let sub = "시급/건별/월 단가 중 원하는 범위를 선택해주세요"
        static let placeholder = "비용을 입력해주세요"
    }
    
    private let titleLabel = UILabel().then {
        $0.text = Strings.main
        $0.font = UIFont.pretendard(size: 24, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = Strings.sub
        $0.font = UIFont.pretendard(size: 14, weight: .regular)
        $0.textColor = UIColor(hexString: "#76797D")
        $0.numberOfLines = 2
    }
    
    private let dropView = CustomDropdown().then {
        $0.placeholder = "구분"
        $0.items = ["시급", "건수", "월별"]
        $0.onSelectionChanged = { selectedValue in
            Logger.d("선택: \(selectedValue)")
        }
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
    
    private let textField = UnderlineTextField().then {
        $0.placeholder = Strings.placeholder
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
        
        subTitleLabel.snp.makeConstraints( { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(26)
        })
        
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
    }
    
    @objc
    func nextTo() {
        coordinator?.nextToLinkerFourth()
    }
    
}
