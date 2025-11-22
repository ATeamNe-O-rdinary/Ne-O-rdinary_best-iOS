//
//  LoginCoordinator.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/22/25.
//

import Foundation
import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func loginCoordinatorDidFinish(_ coordinator: LoginCoordinator)
}

// MARK: - LoginCoordinator
class LoginCoordinator: NSObject, UINavigationControllerDelegate {
    var navigationController: UINavigationController
    weak var delegate: LoginCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    func start() {
        let loginStartVC = LoginViewController()
        loginStartVC.coordinator = self
        navigationController.viewControllers = [loginStartVC]
    }
    
    func nextToPage1() {
        let vc = LoginSelect1ViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finishLogin() {
        //        UserDefaults.standard.set(true, forKey: "isLoggedIn")
        delegate?.loginCoordinatorDidFinish(self)
    }
}
