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
  
  private let swiftUIView = MyProfileView()   // SwiftUI View 넣기
  private var hostingController: UIHostingController<MyProfileView>?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupConstraints()
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
      $0.edges.equalToSuperview()    // 화면 전체 채우기
    }
  }
}
