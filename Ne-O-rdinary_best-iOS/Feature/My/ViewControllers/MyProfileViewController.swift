//
//  MyProfileViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/22/25.
//

import Foundation
import SwiftUI
import SnapKit

final class MyProfileViewController: UIViewController {
    
    private let swiftUIView = MyProfileView()
    private var hostingController: UIHostingController<MyProfileView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupUI() {
        hostingController = UIHostingController(rootView: swiftUIView)
        guard let hostingController else { return }
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    private func setupConstraints() {
        guard let hostingController else { return }
        
        hostingController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let logoLabel = UILabel().then {
            $0.text = "링크팅"
            $0.font = UIFont.pretendard(size: 18, weight: .bold)
            $0.textColor = .black
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoLabel)
        navigationItem.rightBarButtonItem = nil
        navigationItem.hidesBackButton = true
    }
}
