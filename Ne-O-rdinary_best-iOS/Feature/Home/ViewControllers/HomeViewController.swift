//
//  HomeViewController.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 지상률 on 11/22/25.
//

import Foundation
import SwiftUI
import Then
import SnapKit
import KakaoSDKUser
import KakaoSDKCommon

class HomeViewController: UIViewController {
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
      self.view.backgroundColor = .red
    
    // SwiftUI View 생성
    let swiftUIView = HomeRootView()
    
    // HostingController에 감싸기
    let hostingController = UIHostingController(rootView: swiftUIView)
    
    // 현재 ViewController에 child로 추가
    addChild(hostingController)
    view.addSubview(hostingController.view)
    
    // AutoLayout 활성화
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    
    // SwiftUI 화면을 전체 화면에 꽉 채우기
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    // child 등록 마무리
    hostingController.didMove(toParent: self)
  }
}
