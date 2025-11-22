//
//  SelectedCollectionViewCell.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import UIKit
import Then
import SnapKit

class SelectableCollectionViewCell: UICollectionViewCell {
    private var isSelectedState = false
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private let borderLayer = CAShapeLayer()
    
    var borderWidth: CGFloat = 2.0
    var cornerRadius: CGFloat = 12.0
    
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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        updateBorder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBorder()
    }
    
    private func updateBorder() {
        contentView.layer.borderWidth = borderWidth
        contentView.layer.borderColor = isSelectedState ? selectedBorderColor.cgColor : borderColor.cgColor
    }
    
    func configure(with text: String, isSelected: Bool) {
        titleLabel.text = text
        setSelected(isSelected, animated: false)
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
//    
//    var isSelected: Bool {
//        return isSelectedState
//    }
}
