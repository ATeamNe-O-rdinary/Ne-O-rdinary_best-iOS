//
//  StackCardView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//
import SwiftUI

struct StackCardView: View {
  @EnvironmentObject var homeViewModel: HomeViewModel
  
  var user: ProjectProfile
  
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
        FrontFace(user: user, size: size, topOffset: topOffset)
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
      
      if user.linkoId == id {
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

// MARK: - 뒷면 UI
extension StackCardView {
  @ViewBuilder
  func backFace(size: CGSize, topOffset: CGFloat) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 24)
        .fill(.white)
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        .shadow(radius: 4)
      
      VStack(alignment: .leading, spacing: 0) {
        VStack(spacing: 24) {
          VStack(alignment: .leading, spacing: 8) {
            Text("프로젝트 시작일")
              .foregroundColor(Color(hex: "777980"))
              .font(.pretendard(14, .regular))
            
            Text(user.deadline)
              .foregroundColor(Color(hex: "222222"))
              .font(.pretendard(14, .medium))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          
          // MARK: - 스킬
          VStack(alignment: .leading, spacing: 8) {
            Text("요구 스킬")
              .foregroundColor(Color(hex: "777980"))
              .font(.pretendard(14, .regular))
            
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 8) {
                ForEach(user.techStacks, id: \.self) { tag in
                  TagChip(text: tag.description)
                }
              }
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          
          // MARK: - 경험
          VStack(alignment: .leading, spacing: 8) {
            Text("진행 했던 프로젝트")
              .foregroundColor(Color(hex: "777980"))
              .font(.pretendard(14, .regular))
            
            Text("금융 앱 서비스 구축 / 2025.09 ~ 2025.12")
              .foregroundColor(Color(hex: "222222"))
              .font(.pretendard(14, .medium))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          
          // MARK: - 링커 PR
          VStack(alignment: .leading, spacing: 8) {
            Text("링오 PR")
              .foregroundColor(Color(hex: "777980"))
              .font(.pretendard(14, .regular))
            
            VStack(alignment: .leading, spacing: 8) {
              HStack(spacing: 6) {
                Image(R.Images.check)
                  .foregroundColor(Color(hex: "FF704D"))
                Text("초보도 가능해요")
                  .foregroundColor(Color(hex: "222222"))
                  .font(.pretendard(14, .medium))
              }
              
              HStack(spacing: 6) {
                Image(R.Images.check)
                  .foregroundColor(Color(hex: "FF704D"))
                Text("시간을 잘 지켜요")
                  .foregroundColor(Color(hex: "222222"))
                  .font(.pretendard(14, .medium))
              }
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(16)
        
        Spacer()
        
        // MARK: - 포트폴리오 링크
        VStack(alignment: .leading, spacing: 6) {
          Text("기업 사이트")
            .foregroundColor(Color(hex: "777980"))
            .font(.pretendard(14, .regular))
          
          HStack {
            Image(R.Images.link)
              .foregroundColor(Color(hex: "FE6F53"))
            Text("https://www.linkting.com")
              .foregroundColor(Color(hex: "76797D"))
              .font(.pretendard(14, .regular))
            Spacer()
          }
          .padding(14)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .fill(Color(hex: "F7F7F7"))
          )
        }
        .padding(16)
        .background(
          RoundedRectangle(cornerRadius: 12)
            .fill(.white)
            .overlay(
              RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "EDEDED"), lineWidth: 1)
            )
        )
      }
      .padding(12)
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
                                    userInfo: ["id": first.linkoId, "rightSwipe": rightSwipe]
    )
  }
}

extension View {
  func getRect() -> CGRect { UIScreen.main.bounds }
}
