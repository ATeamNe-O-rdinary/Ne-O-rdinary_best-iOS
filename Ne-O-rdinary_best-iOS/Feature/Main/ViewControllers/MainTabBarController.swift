//
//  MainTabBarController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let firstVC = HomeViewController()
        let thirdVC = MyProfileViewController()
        firstVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        thirdVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person.fill"), tag: 2)
        
        let tabs = [firstVC, thirdVC]
        self.viewControllers = tabs
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .orange
        setViewControllers(tabs.map { UINavigationController(rootViewController: $0) } , animated: false)
    }
}
