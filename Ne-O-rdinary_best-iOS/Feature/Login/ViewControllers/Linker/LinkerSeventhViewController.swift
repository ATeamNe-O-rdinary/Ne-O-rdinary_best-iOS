//
//  LinkerSeventhViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/23/25.
//

import UIKit
import Then
import SnapKit

final class LinkerSeventhViewController: UIViewController {
    
    private enum Strings {
        static let title = "사용 가능한 툴과\n기술 스택을 선택해주세요"
    }
    
    private let titleLabel = UILabel().then {
        $0.text = Strings.title
        $0.font = UIFont.pretendard(size: 24, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 2
    }
    
    private let flowLayout = LeftAlignedCollectionViewFlowLayout().then {
        $0.minimumInteritemSpacing = 8
        $0.minimumLineSpacing = 12
    }
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: flowLayout
    ).then {
        $0.backgroundColor = .white
        $0.register(SelectableCollectionViewCell.self, forCellWithReuseIdentifier: "SelectableCell")
    }
    
    private var items: [String] = [
        "Swift",
        "Kotlin",
        "Java",
        "Flutter",
        "React Native",
        "Node.js",
        "Python(Django/FastAPI)",
        "Spring(Java)"
    ]
    
    private let nextButton = UIButton().then {
        $0.backgroundColor = UIColor(hexString: "#FF704D")
        $0.setTitle("다음으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(size: 16, weight: .regular)
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private var selectedIndices: Set<Int> = []
    
    var coordinator: LoginCoordinator?
    
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
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(nextButton)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(177)
            make.leading.equalToSuperview().offset(26)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().inset(26)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.height.equalTo(52)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().inset(26)
            make.bottom.equalTo(nextButton.snp.top).offset(34)
        }
        
    }
    
    func setupActions() {
        nextButton.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
    }
    
    @objc private func nextButtonTap() {
        coordinator?.nextToLinkerLast()
    }
}

// MARK: - UICollectionViewDataSource
extension LinkerSeventhViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SelectableCell",
            for: indexPath
        ) as! SelectableCollectionViewCell
        
        let isSelected = selectedIndices.contains(indexPath.item)
        cell.configure(with: items[indexPath.item], isSelected: isSelected)
        
        return cell
    }
}

extension LinkerSeventhViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if selectedIndices.contains(indexPath.item) {
            selectedIndices.remove(indexPath.item)
        } else {
            selectedIndices.insert(indexPath.item)
        }
        
        collectionView.reloadItems(at: [indexPath])
        
        let selectedItems = selectedIndices.sorted().map { items[$0] }
        print("선택된 항목: \(selectedItems)")
    }
}

extension LinkerSeventhViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cell = SelectableCollectionViewCell()
        let isSelected = selectedIndices.contains(indexPath.item)
        cell.configure(with: items[indexPath.item], isSelected: isSelected)
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: 37)
        let cellSize: CGSize = cell.contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .required
        )
        Logger.d("\(cellSize)")
        return cellSize
    }
}
