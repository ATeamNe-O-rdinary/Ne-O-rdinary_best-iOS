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
        let secondVC = CommunityViewController()
        let thirdVC = MyProfileViewController()
        firstVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        secondVC.tabBarItem = UITabBarItem(title: "커뮤니티", image: UIImage(systemName: "book.fill"), tag: 1)
        thirdVC.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(systemName: "person.fill"), tag: 2)
        
        self.viewControllers = [firstVC, secondVC, thirdVC]
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .orange
    
    }
}


