import Foundation
import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func loginCoordinatorDidFinish(_ coordinator: LoginCoordinator)
}

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
    
    func nextToLinkerFirst() {
        let vc = LinkerFirstViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func nextToLinkerSecond() {
        let vc = LinkerSecondViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func nextToLinkerThird() {
        let vc = LinkerThirdViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func nextToLinkerFourth() {
        let vc = LinkerFourthViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
   
    func nextToLinkerFifth() {
        let vc = LinkerFifthViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func nextToLinkerSixth() {
        let vc = LinkerSixthViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func nextToLinkerSeventh() {
        let vc = LinkerSeventhViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func nextToLinkerLast() {
        let vc = LinkerLastViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func finishLogin() {
        Logger.d("로그인 완료!")
        delegate?.loginCoordinatorDidFinish(self)
        NotificationCenter.default.post(name: NSNotification.Name("LoginDidFinish"), object: nil)
    }
}
