//
//  LinkTalkListViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


import UIKit
import SwiftUI
import SnapKit

final class LinkTalkListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupUI()
    }
    
    private func setupNav() {
      navigationItem.title = "링크톡"
      navigationController?.navigationBar.prefersLargeTitles = false
      navigationController?.navigationBar.tintColor = .black
    }
    
    private func setupUI() {
        let content = LinkTalkListView { [weak self] talk in
            let vc = LinkTalkChatViewController(talk: talk)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        let host = UIHostingController(rootView: content)
        addChild(host)
        view.addSubview(host.view)
        
        host.view.snp.makeConstraints { $0.edges.equalToSuperview() }
        host.didMove(toParent: self)
    }
}
