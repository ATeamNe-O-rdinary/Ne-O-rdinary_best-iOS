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
            user: User(name: "", place: "", profilePic: "User1"),
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
