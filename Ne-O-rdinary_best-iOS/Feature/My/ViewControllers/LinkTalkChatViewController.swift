//
//  LinkTalkChatViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


import UIKit
import SwiftUI
import SnapKit

final class LinkTalkChatViewController: UIViewController {
    
    private let talk: LinkTalkPreview
    
    init(talk: LinkTalkPreview) {
        self.talk = talk
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupUI()
    }
    
    private func setupNav() {
      navigationController?.navigationBar.prefersLargeTitles = false
      navigationController?.navigationBar.tintColor = .black
      navigationItem.title = talk.company
    }
    
    private func setupUI() {
        let host = UIHostingController(rootView: LinkTalkChatView(talk: talk))
        addChild(host)
        view.addSubview(host.view)
        
        host.view.snp.makeConstraints { $0.edges.equalToSuperview() }
        host.didMove(toParent: self)
    }
}
