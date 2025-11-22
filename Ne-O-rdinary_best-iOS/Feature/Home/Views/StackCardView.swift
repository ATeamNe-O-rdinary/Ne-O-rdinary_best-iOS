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
  
  @State private var offset: CGFloat = 0
  @GestureState var isDragging: Bool = false
  
  @State private var endSwipe: Bool = false
  
  var body: some View {
    GeometryReader { proxy in
      let size = proxy.size
      let index = CGFloat(homeViewModel.getIndex(user: user))
      
      let topOffset = (index <= 2 ? index : 2) * 15
      
      ZStack {
        Image(user.profilePic)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: size.width - topOffset, height: size.height)
          .clipShape(.rect(cornerRadius: 15))
          .offset(y: topOffset)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    .offset(x: offset)
    .rotationEffect(.init(degrees: getRotation(angle: 8)))
    .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
    .gesture(
      DragGesture()
        .updating($isDragging, body: { value, out, _ in
          out = true
        })
        .onChanged({ value in
          let translation = value.translation.width
          offset = (isDragging ? translation : .zero)
        })
        .onEnded({ value in
          let width = getRect().width - 50
          let translation = value.translation.width
          
          let checkingStatus = (translation > 0 ? translation : -translation)
          
          withAnimation {
            if checkingStatus > (width / 2) {
              offset = (translation > 0 ? width : -width) * 2
              endSwipe = true
            } else {
              offset = .zero
            }
          }
        })
    )
  }
  
  func getRotation(angle: Double) -> Double {
    let rotation = (offset / (getRect().width - 50)) * angle
    
    return rotation
  }
  
  func endSwipeActions() {
    withAnimation(.none) {
      endSwipe = true
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      if let _ = homeViewModel.displayingUsers?.first {
        let _ = withAnimation {
          homeViewModel.displayingUsers?.removeFirst()
        }
      }
    }
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
