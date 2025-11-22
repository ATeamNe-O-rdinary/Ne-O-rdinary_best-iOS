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

  // 🔥 추가: 플립 상태
  @State private var isFlipped: Bool = false
  
  var body: some View {
    GeometryReader { proxy in
      let size = proxy.size
      let index = CGFloat(homeViewModel.getIndex(user: user))
      let topOffset = (index <= 2 ? index : 2) * 15
      
      ZStack {

        // -------- 앞면 --------
        frontFace(size: size, topOffset: topOffset)
          .opacity(isFlipped ? 0 : 1)

        // -------- 뒷면 --------
        backFace(size: size, topOffset: topOffset)
          .opacity(isFlipped ? 1 : 0)
          .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
      }
      .frame(width: size.width - topOffset, height: size.height)
      .clipShape(.rect(cornerRadius: 15))
      .offset(y: topOffset)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
      
      // 전체 카드에 플립 효과 적용
      .rotation3DEffect(.degrees(isFlipped ? 180 : 0),
                        axis: (x: 0, y: 1, z: 0))
      .animation(.easeInOut(duration: 0.35), value: isFlipped)
      
      // 🔥 탭하면 뒤집기 (스와이프와 충돌 안함)
      .onTapGesture {
        withAnimation {
          isFlipped.toggle()
        }
      }
    }
    .offset(x: offset)
    .rotationEffect(.init(degrees: getRotation(angle: 8)))
    .contentShape(Rectangle().trim(from: 0, to: endSwipe ? 0 : 1))
    
    // -------- 스와이프 제스처 기존 그대로 유지 --------
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
          let checkingStatus = abs(translation)
          
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
    
    // 기존 Notification (버튼 액션)
    .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ACTIONFROMBUTTON"), object: nil)) { data in
      guard let info = data.userInfo else { return }
      
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
}

// MARK: - 앞면 UI
extension StackCardView {
  @ViewBuilder
  func frontFace(size: CGSize, topOffset: CGFloat) -> some View {
      ZStack {
          RoundedRectangle(cornerRadius: 24)
            .fill(.white)
            .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
            .shadow(radius: 4)
        VStack {
          ZStack(alignment: .bottom) {
            Image(user.profilePic)
              .resizable()
              .frame(height: 228)
              .clipShape(RoundedRectangle(cornerRadius: 12))
            
            HStack {
              VStack(alignment: .leading, spacing: 4) {
                Text("프론트엔드 개발자 주니어")
                Text("이름")
              }
              Spacer()
              Image("link_icon")
                .frame(width: 48, height: 48)
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .background(
              RoundedRectangle(cornerRadius: 12)
                .fill(Color.white).opacity(0.2)
                .overlay(
                  RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.systemGray4), lineWidth: 1)
                )
            )
            .padding(16)
          }
          .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
          Spacer()
        }
      }
      .padding(4)
      .frame(width: size.width - topOffset, height: size.height)
  }
}

// MARK: - 뒷면 UI
extension StackCardView {
  @ViewBuilder
  func backFace(size: CGSize, topOffset: CGFloat) -> some View {
    ZStack {
        RoundedRectangle(cornerRadius: 24)
          .fill(.white)
          .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
          .shadow(radius: 4)
      
      VStack {
        Text("안녕")
        Text("다른 정보 표시 가능")
      }
      .foregroundColor(.black)
    }
    .padding(4)
    .frame(width: size.width - topOffset, height: size.height)
  }
}

// MARK: - 기존 로직 유지
extension StackCardView {
  
  func getRotation(angle: Double) -> Double {
    (offset / (getRect().width - 50)) * angle
  }
  
  func endSwipeActions() {
    withAnimation(.none) {
      endSwipe = true
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      if let _ = homeViewModel.displayingUsers?.first {
        withAnimation {
          homeViewModel.displayingUsers?.removeFirst()
        }
      }
    }
  }
  
  func leftSwipe() { Logger.d("Left Swipe") }
  func rightSwipe() { Logger.d("Right Swipe") }
  
  func doSwipe(rightSwipe: Bool = false) {
    guard let first = homeViewModel.displayingUsers?.first else { return }
    NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil,
      userInfo: ["id": first.id, "rightSwipe": rightSwipe]
    )
  }
}

extension View {
  func getRect() -> CGRect { UIScreen.main.bounds }
}
