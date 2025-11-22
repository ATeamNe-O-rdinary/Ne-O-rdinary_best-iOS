//
//  SelectedBorderView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import Foundation
import UIKit
import Then
import SnapKit

class SelectableBorderView: UIView {
    
    private var isSelectedState = false
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    var borderWidth: CGFloat = 1.0 {
        didSet {
            updateBorder()
        }
    }
    
    var cornerRadius: CGFloat = 8.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
        }
    }
    
    var borderColor: UIColor = UIColor(hexString: "#EAECEE") {
        didSet {
            if !isSelectedState {
                updateBorder()
            }
        }
    }
    
    var selectedBorderColor: UIColor = UIColor(hexString: "#FF704D") {
        didSet {
            if isSelectedState {
                updateBorder()
            }
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setConstraint()
    }
    
    private func setupUI() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        updateBorder()
        
        addSubview(titleLabel)
    }
    
    private func updateBorder() {
        layer.borderWidth = borderWidth
        layer.borderColor = isSelectedState ? selectedBorderColor.cgColor : borderColor.cgColor
    }
    
    private func setConstraint() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func setSelected(_ selected: Bool, animated: Bool = true) {
        guard isSelectedState != selected else { return }
        
        isSelectedState = selected
        
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.updateBorder()
            }
        } else {
            updateBorder()
        }
    }
    
    func toggleSelection(animated: Bool = true) {
        setSelected(!isSelectedState, animated: animated)
    }
    
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    
    var isSelected: Bool {
        return isSelectedState
    }
}
