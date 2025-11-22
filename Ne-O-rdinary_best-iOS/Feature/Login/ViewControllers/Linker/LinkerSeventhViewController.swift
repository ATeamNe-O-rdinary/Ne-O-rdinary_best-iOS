import UIKit
import Then
import SnapKit

final class LinkerSeventhViewController: UIViewController {
    
    private enum Strings {
        static let title = "사용 가능한 툴과\n기술 스택을 선택해주세요"
    }
    
    private let viewModel = SharedLinkerViewModel.shared
    
    private let titleLabel = UILabel().then {
        $0.text = Strings.title
        $0.font = UIFont.pretendard(size: 24, weight: .semibold)
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
    
    private let techStacks: [TechStack] = [
        .swift, .kotlin, .java, .flutter,
        .reactNative, .nodeJS, .pythonDjangoFastAPI, .springJava
    ]
    
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
    
    private var selectedIndices: Set<Int> = []
    
    var coordinator: LoginCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViewModel() {
        viewModel.stateDidChange = { [weak self] state in
            switch state {
            case .idle:
                break
                
            case .loading:
                Logger.d("링커 정보 전송 중...")
                self?.nextButton.isEnabled = false
                self?.nextButton.alpha = 0.5
                
            case .success:
                Logger.d("링커 정보 등록 성공!")
                self?.nextButton.isEnabled = true
                self?.nextButton.alpha = 1.0
                self?.coordinator?.nextToLinkerLast()
                
            case .failure(let error):
                Logger.e("등록 실패: \(error)")
                self?.nextButton.isEnabled = true
                self?.nextButton.alpha = 1.0
                self?.showAlert(title: "오류", message: error)
            }
        }
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
            make.bottom.equalTo(nextButton.snp.top).offset(-34)
        }
    }
    
    func setupActions() {
        nextButton.addTarget(self, action: #selector(nextButtonTap), for: .touchUpInside)
    }
    
    @objc private func nextButtonTap() {
        guard !selectedIndices.isEmpty else {
            showAlert(title: "선택 필요", message: "최소 하나의 기술 스택을 선택해주세요")
            return
        }
        
        // 선택된 기술 스택을 enum 값으로 변환
        let selectedTechStacks = selectedIndices.sorted().map { techStacks[$0].rawValue }
        
        // ViewModel에 데이터 저장
        viewModel.setTechStacks(selectedTechStacks)
        Logger.d("저장된 기술 스택: \(selectedTechStacks)")
        
        // POST 요청 전송
        viewModel.submitUserData()
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension LinkerSeventhViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return techStacks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SelectableCell",
            for: indexPath
        ) as! SelectableCollectionViewCell
        
        let isSelected = selectedIndices.contains(indexPath.item)
        cell.configure(with: techStacks[indexPath.item].description, isSelected: isSelected)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension LinkerSeventhViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        if selectedIndices.contains(indexPath.item) {
            selectedIndices.remove(indexPath.item)
        } else {
            selectedIndices.insert(indexPath.item)
        }
        
        collectionView.reloadItems(at: [indexPath])
        updateButtonState()
        
        let selectedItems = selectedIndices.sorted().map { techStacks[$0].description }
        Logger.d("선택된 기술 스택: \(selectedItems)")
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LinkerSeventhViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let text = techStacks[indexPath.item].description
        let font = UIFont.pretendard(size: 16, weight: .regular)
        
        let textSize = text.size(withAttributes: [.font: font])
        let width = textSize.width + 60  // 좌우 패딩 20pt씩
        let height: CGFloat = 37  // 위아래 패딩 10pt씩
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - 버튼 상태 관리
extension LinkerSeventhViewController {
    private func updateButtonState() {
        let hasSelection = !selectedIndices.isEmpty
        nextButton.isEnabled = hasSelection
        UIView.animate(withDuration: 0.2) {
            self.nextButton.alpha = hasSelection ? 1.0 : 0.5
        }
    }
}
