//
//  DropDownView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import UIKit
import Then
import SnapKit

class CustomDropdown: UIView {
    
    private let button = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitleColor(UIColor(hexString: "#777980"), for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .medium)
    }
    
    private let underlineView = UIView().then {
        $0.backgroundColor = UIColor(hexString: "#EAECEE")
    }
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.isHidden = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hexString: "#EAECEE").cgColor
        $0.separatorStyle = .none
    }
    
    private var dropdownWindow: UIWindow?
    private var selectedItem: String?
    var onSelectionChanged: ((String) -> Void)?
    
    var items: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var placeholder: String = "선택하세요" {
        didSet {
            if selectedItem == nil {
                button.setTitle(placeholder, for: .normal)
            }
        }
    }
    
    var inactiveLineColor: UIColor = UIColor(hexString: "#EAECEE") {
        didSet {
            underlineView.backgroundColor = inactiveLineColor
        }
    }
    
    var activeLineColor: UIColor = UIColor(hexString: "#FF704D")
    
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
        addSubview(button)
//        addSubview(underlineView)
        var config = UIButton.Configuration.plain()
        config.title = "구분"
        config.image = R.Images.$downArrow
        config.imagePadding = 8
        config.imagePlacement = .trailing
        button.configuration = config
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // TableView 설정
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownCell")
        tableView.rowHeight = 44
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(43)
        }
        
//        underlineView.snp.makeConstraints { make in
//            make.top.equalTo(button.snp.bottom).offset(8)
//            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(1)
//        }
    }
    
    // MARK: - Actions
    @objc private func buttonTapped() {
        if tableView.isHidden {
            showDropdown()
        } else {
            hideDropdown()
        }
    }
    
    private func showDropdown() {
        tableView.isHidden = false
        if let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?.windows
            .first {
            
            let buttonFrame = button.convert(button.bounds, to: window)
            let maxHeight: CGFloat = CGFloat(items.count) * 44
            let height = min(maxHeight, 200)
            
            tableView.frame = CGRect(
                x: buttonFrame.minX,
                y: buttonFrame.maxY + 8,
                width: buttonFrame.width,
                height: height
            )
            
            window.addSubview(tableView)
            window.bringSubviewToFront(tableView)
        }
        
//        updateUnderlineColor(isActive: true)
    }
    
    private func hideDropdown() {
        tableView.isHidden = true
        tableView.removeFromSuperview()
        underlineView.isHidden = false
//        updateUnderlineColor(isActive: false)
    }
    
    private func updateUnderlineColor(isActive: Bool = false) {
        UIView.animate(withDuration: 0.2) {
            self.underlineView.backgroundColor = isActive ? self.activeLineColor : self.inactiveLineColor
        }
    }
    
    // MARK: - Public Methods
    var selectedValue: String? {
        return selectedItem
    }
    
    func reset() {
        selectedItem = nil
        button.setTitle(placeholder, for: .normal)
        hideDropdown()
    }
}

extension CustomDropdown: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.font = UIFont.pretendard(size: 16, weight: .medium)
        cell.backgroundColor = .white
        
        // 구분선 추가
        let separator = UIView()
        separator.backgroundColor = UIColor(hexString: "#EAECEE")
        cell.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        if items[indexPath.row] == selectedItem {
            cell.textLabel?.textColor = UIColor(hexString: "#FF704D")
        } else {
            cell.textLabel?.textColor = .black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = items[indexPath.row]
        selectedItem = selected
        button.setTitle(selected, for: .normal)
        onSelectionChanged?(selected)
        hideDropdown()
        tableView.reloadData()
    }
}
