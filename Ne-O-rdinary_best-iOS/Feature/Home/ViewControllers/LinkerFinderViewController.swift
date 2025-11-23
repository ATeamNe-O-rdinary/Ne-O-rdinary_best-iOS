//
//  LinkerFinderViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/22/25.
//

import Foundation
import SwiftUI
import SnapKit

final class LinkerFinderViewController: UIViewController {
    
    private var hostingController: UIHostingController<LinkerFinderView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        let swiftUIView = LinkerFinderView(navigateToLinkedCompanies: { [weak self] in
            self?.presentLoginFlow()
        })
        
        hostingController = UIHostingController(rootView: swiftUIView)
        guard let hostingController else { return }
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        guard let hostingController else { return }
        hostingController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - 로그인 화면 표시
    private func presentLoginFlow() {
        let navController = UINavigationController()
        let loginCoordinator = LoginCoordinator(navigationController: navController)
        loginCoordinator.delegate = self
        loginCoordinator.start()
        
        // Notification으로 rootViewController 변경
        NotificationCenter.default.post(
            name: NSNotification.Name("PresentLoginFlow"),
            object: navController
        )
    }
}

extension LinkerFinderViewController: LoginCoordinatorDelegate {
    func loginCoordinatorDidFinish(_ coordinator: LoginCoordinator) {
        // Notification으로 로그인 완료 알림
        NotificationCenter.default.post(name: NSNotification.Name("LoginDidFinish"), object: nil)
    }
}
