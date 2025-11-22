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

final class HomeViewController: UIViewController {
    private lazy var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal).then {
//        $0.dataSource = self
        $0.delegate = self
    }
    
    private var viewControllers: [UIViewController] {
        [LinkerFinderViewController(), RecommendViewController()]
    }
    
    private let tabItems: [PageTab] = [.linker, .recommend]
    
    private lazy var tabButtons: [PageTabButton] = tabItems.map {
        return PageTabButton(tab: $0)
    }
    
    private let tabContainerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let tabStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fillProportionally
        $0.spacing = 0
    }
    
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
    
    @objc private func buttonTapped(_ sender: UIButton) {
         guard let index = tabButtons.firstIndex(of: sender as! PageTabButton) else { return }
         
         tabButtons.forEach { $0.isSelected = false }
         tabButtons[index].isSelected = true
         
         let direction: UIPageViewController.NavigationDirection = index > 0 ? .forward : .reverse
         pageViewController.setViewControllers([viewControllers[index]], direction: direction, animated: true)
     }
    
    private func setupUI() {
        for button in tabButtons {
            tabStackView.addArrangedSubview(button)
        }
        tabContainerView.addSubview(tabStackView)
        view.addSubview(tabContainerView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        tabContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        tabStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(tabContainerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UIPageViewControllerDelegate {
}

