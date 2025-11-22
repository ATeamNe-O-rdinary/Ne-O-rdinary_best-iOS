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
              endSwipeActions()
              if translation > 0 {
                rightSwipe()
              } else {
                leftSwipe()
              }
            } else {
              offset = .zero
            }
          }
        })
    )
    .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
      guard let info = data.userInfo else {
        return
      }
      
      let id = info["id"] as? String ?? ""
      let rightSwipe = info["rightSwipe"] as? Bool ?? false
      let width = getRect().width - 50
      
      if user.id == id {
        withAnimation {
          offset = (rightSwipe ? width : -width) * 2
          endSwipeActions()
          
          if rightSwipe {
            self.rightSwipe()
          } else {
            leftSwipe()
          }
        }
      }
    }
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
  
  func leftSwipe() {
    Logger.d("Left Swipe")
  }
  
  func rightSwipe() {
    Logger.d("Right Swipe")
  }
  
  func doSwipe(rightSwipe: Bool = false) {
    guard let first = homeViewModel.displayingUsers?.first else {
      return
    }
    
    NotificationCenter.default.post(name:  NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
      "id" : first.id,
      "rightSwipe": rightSwipe
    ])
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
