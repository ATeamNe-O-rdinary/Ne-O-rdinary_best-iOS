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
            user:
              MemberProfile(linkerId: "1", nickname: "happy", careerLevel: .junior, workTimeType: .anytime, rateUnit: .hourly, collaborationType: .both, region: .anywhere, techStacks: [.flutter, .java, .kotlin], categoryOfBusiness: .aiDev, jobCategory: "WEB_DEV", oneLineDescription: "5년차 백엔드 개발자입니다. 대용량 트래픽 처리 경험 다수.", rateAmount: 500000, profileImage: "https://s3.ap-northeast-2.amazonaws.com/bucket/linker-profile/456.png"),
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
