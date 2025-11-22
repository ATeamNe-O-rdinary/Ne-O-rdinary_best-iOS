//
//  LinkedCompaniesViewController.swift
//  Ne-O-rdinary_best-iOS
//

import UIKit
import SwiftUI
import SnapKit

final class LinkedCompaniesViewController: UIViewController {
    
    private let linkedCompaniesView = LinkedCompaniesView()
    private var hostingController: UIHostingController<LinkedCompaniesView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupUI() {
        hostingController = UIHostingController(rootView: linkedCompaniesView)
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
        navigationItem.title = "링크한 기업"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .black
    }
}
