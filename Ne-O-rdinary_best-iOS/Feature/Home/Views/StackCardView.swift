//
//  StackCardView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import SwiftUI

struct StackCardView: View {
  @EnvironmentObject var homeViewModel: HomeViewModel
  
  var user: User
  
  @GestureState var isDragging: Bool = false
  @State private var offset: CGFloat = 0
  @State private var endSwipe: Bool = false
  @State private var isFlipped: Bool = false
  
  var body: some View {
    GeometryReader { proxy in
      let size = proxy.size
      let index = CGFloat(homeViewModel.getIndex(user: user))
      let topOffset = (index <= 2 ? index : 2) * 15
      
      ZStack {

        // --- 카드 앞면 ---
        frontCard(size: size, topOffset: topOffset)
          .opacity(isFlipped ? 0 : 1)

        // --- 카드 뒷면 ---
        backCard(size: size, topOffset: topOffset)
          .opacity(isFlipped ? 1 : 0)
          .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
      .animation(.easeInOut(duration: 0.4), value: isFlipped)
      .onTapGesture {
        withAnimation {
          isFlipped.toggle()
        }
      }
    }
    .offset(x: offset)
    .rotationEffect(.init(degrees: getRotation(angle: 8)))
    .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
    .gesture(
      DragGesture()
        .updating($isDragging) { value, out, _ in out = true }
        .onChanged { value in
          let translation = value.translation.width
          offset = (isDragging ? translation : .zero)
        }
        .onEnded { value in
          let width = getRect().width - 50
          let translation = value.translation.width
          let checkingStatus = abs(translation)
          
          withAnimation {
            if checkingStatus > (width / 2) {
              offset = (translation > 0 ? width : -width) * 2
              endSwipe = true
            } else {
              offset = .zero
            }
          }
        }
    )
  }
  
  @ViewBuilder
  func frontCard(size: CGSize, topOffset: CGFloat) -> some View {
    Image(user.profilePic)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: size.width - topOffset, height: size.height)
      .clipShape(.rect(cornerRadius: 15))
      .offset(y: topOffset)
  }
  
  @ViewBuilder
  func backCard(size: CGSize, topOffset: CGFloat) -> some View {
    ZStack {
      Color.white
      VStack {
        Text("안녕")
          .font(.title)
        Text("Age: \(user.place)")
      }
      .foregroundColor(.black)
    }
    .frame(width: size.width - topOffset, height: size.height)
    .clipShape(.rect(cornerRadius: 15))
    .offset(y: topOffset)
  }

  func getRotation(angle: Double) -> Double {
    let rotation = (offset / (getRect().width - 50)) * angle
    return rotation
  }
}

#Preview {
  HomeRootView()
}

extension View {
  func getRect() -> CGRect {
    return UIScreen.main.bounds
  }
}
