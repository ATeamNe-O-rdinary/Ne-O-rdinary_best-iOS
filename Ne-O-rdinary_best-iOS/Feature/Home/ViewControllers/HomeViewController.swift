//
//  HomeViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/22/25.
//

import Foundation
import SwiftUI
import Then
import SnapKit

class HomeViewController: UIViewController {
    private var statusBarHeight: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .statusBarManager?
            .statusBarFrame.height ?? 0
    }
    
    private let headerLabel = UILabel().then {
        $0.text = "링크팅"
        $0.font = .pretendard(size: 16, weight: .semibold)
        $0.textColor = .black
    }
    
    /// PageViewController
    private lazy var pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    ).then {
        $0.delegate = self
    }
    
    /// 페이지 목록
    private var viewControllers: [UIViewController] {
        [LinkerFinderViewController(), RecommendViewController()]
    }
    
    /// 탭 항목
    private let tabItems: [PageTab] = [.linker, .recommend]
    
    /// 탭 버튼들
    private lazy var tabButtons: [PageTabButton] = tabItems.map {
        return PageTabButton(tab: $0)
    }
    
    /// 탭 컨테이너
    private let tabContainerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    /// 탭 스택뷰
    private let tabStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually      // ← 버튼 반반 고정
        $0.spacing = 0
    }
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        
        for button in tabButtons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        if let firstVC = viewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false)
        }
        tabButtons[0].isSelected = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        // ── 상단 헤더 추가 ──────────────────────────
        view.addSubview(headerLabel)
        
        // ── 탭 버튼 스택뷰 ──────────────────────────
        for button in tabButtons {
            tabStackView.addArrangedSubview(button)
        }
        tabContainerView.addSubview(tabStackView)
        view.addSubview(tabContainerView)
        
        // ── PageViewController ───────────────────────
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    
    // MARK: - Constraints
    private func setupConstraints() {
        headerLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(statusBarHeight + 4)  // +4는 여백
            $0.leading.equalToSuperview().offset(26)
        }
        
        tabContainerView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        tabStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(tabContainerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTabs() {
        for button in tabButtons {
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        if let firstVC = viewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false)
        }
        
        tabButtons.first?.isSelected = true
    }
    
    
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let index = tabButtons.firstIndex(of: sender as! PageTabButton) else { return }
        
        // 탭 선택상태 변경
        tabButtons.forEach { $0.isSelected = false }
        tabButtons[index].isSelected = true
        
        let direction: UIPageViewController.NavigationDirection = index > 0 ? .forward : .reverse
        pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true)
    }
}


// MARK: - PageView Delegate
extension HomeViewController: UIPageViewControllerDelegate {}
