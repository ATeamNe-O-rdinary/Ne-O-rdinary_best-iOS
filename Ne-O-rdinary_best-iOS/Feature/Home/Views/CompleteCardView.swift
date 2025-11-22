//
//  CompleteCardView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//

import SwiftUI
struct CompleteCardView: View {
  @State private var animateCard: Bool = false
  
  var body: some View {
    VStack(spacing: 24) {
      Text("두둥..\n\n당신의\n링오카드가 완성되었어요!")
        .font(.pretendard(30, .medium))
        .foregroundStyle(.black)
        .multilineTextAlignment(.center)
      
      GeometryReader { geo in
          FrontFace(
            user: ProjectProfile(
              linkoId: "1",
              companyName: "테크스타트업 A",
              companyType: "IT_PROGRAMMING",
              mainCategory: "IT_PROGRAMMING",
              categoryOfBusiness: "WEB_DEV",
              projectIntro: "AI 기반 웹 서비스 프론트엔드 개발 프로젝트입니다.",
              expectedDuration: "3개월",
              rateUnit: "HOURLY",
              rateAmount: 50000,
              collaborationType: .both,
              region: "SEOUL",
              deadline: "2025-12-31",
              techStacks: [.reactNative, .flutter, .java],
              profileImage: "company_img1"
          ),
            size: CGSize(width: geo.size.width, height: geo.size.height),
            topOffset: 0
          )
          .offset(y: animateCard ? 0 : 200)
          .opacity(animateCard ? 1 : 0)
          .animation(
            .spring(response: 0.4, dampingFraction: 0.65)
            .delay(0.5),
            value: animateCard
          )
      }
      .padding(.bottom, 40)
      .padding(.horizontal, 16)
      .onAppear {
        animateCard = true
      }
    }
  }
}
