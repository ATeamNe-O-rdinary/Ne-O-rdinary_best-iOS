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
            .aspectRatio(contentMode: .fill)
            .frame(height: 228)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
              // 아래쪽 절반만 검정 그라데이션
              LinearGradient(
                gradient: Gradient(colors: [
                  Color.black.opacity(0.0),
                  Color.black.opacity(0.5)
                ]),
                startPoint: .top,
                endPoint: .bottom
              )
              .clipShape(RoundedRectangle(cornerRadius: 12))
            )
          
          HStack {
            VStack(alignment: .leading, spacing: 4) {
              Text("프론트엔드 개발자 주니어")
                .foregroundStyle(Color(hex: "f2f2f2"))
                .font(.pretendard(12, .regular))
              Text("이름")
                .foregroundStyle(Color(hex: "ffffff"))
                .font(.pretendard(18, .semibold))
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
        
        VStack(alignment: .leading, spacing: 20) {
          VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
              Text("한줄소개")
                .foregroundStyle(Color(hex: "777980"))
                .font(.pretendard(14, .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
              Text("스타트업 근무 중인 프론트엔드 개발자입니다")
                .foregroundStyle(Color(hex: "414245"))
                .font(.pretendard(14, .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 4) {
              HStack(spacing: 12) {
                Text("업무 방식")
                  .foregroundStyle(Color(hex: "777980"))
                  .font(.pretendard(14, .medium))
                Text("풀타임 가능")
                  .foregroundStyle(Color(hex: "222222"))
                  .font(.pretendard(14, .medium))
              }
              
              HStack(spacing: 12) {
                Text("희망 단가")
                  .foregroundStyle(Color(hex: "777980"))
                  .font(.pretendard(14, .medium))
                HStack(spacing: 2) {
                  Text("80,000원")
                    .foregroundStyle(Color(hex: "222222"))
                    .font(.pretendard(14, .medium))
                  Text("건당")
                    .foregroundStyle(Color(hex: "777980"))
                    .font(.pretendard(13, .regular))
                }
              }
              
              HStack(spacing: 12) {
                Text("선호 지역")
                  .foregroundStyle(Color(hex: "777980"))
                  .font(.pretendard(14, .medium))
                Text("서울")
                  .foregroundStyle(Color(hex: "222222"))
                  .font(.pretendard(14, .medium))
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              ForEach(["웹 퍼블리싱", "반응형", "React", "아아아", "오오오오"], id: \.self) { tag in
                TagChip(text: tag)
              }
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(26)
        
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
      
      VStack(alignment: .leading, spacing: 0) {
        VStack(spacing: 24) {
          // MARK: - 스킬
          VStack(alignment: .leading, spacing: 8) {
            Text("스킬")
              .foregroundColor(Color(hex: "777980"))
              .font(.pretendard(14, .regular))
            
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 8) {
                ForEach(["React", "Figma", "Vue", "React", "React", "React"], id: \.self) { tag in
                  TagChip(text: tag)
                }
              }
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          
          // MARK: - 경험
          VStack(alignment: .leading, spacing: 8) {
            Text("경험")
              .foregroundColor(Color(hex: "777980"))
              .font(.pretendard(14, .regular))
            
            Text("링크팅  /  프론트엔드  /  2025.11 ~ 재직 중")
              .foregroundColor(Color(hex: "222222"))
              .font(.pretendard(14, .medium))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          
          // MARK: - 선호 프로젝트 유형
          VStack(alignment: .leading, spacing: 8) {
            Text("선호 프로젝트 유형")
              .foregroundColor(Color(hex: "777980"))
              .font(.pretendard(14, .regular))
            
            Text("1~2개월 단기 선호")
              .foregroundColor(Color(hex: "222222"))
              .font(.pretendard(14, .medium))
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          
          // MARK: - 링커 PR
          VStack(alignment: .leading, spacing: 8) {
            Text("링커 PR")
              .foregroundColor(Color(hex: "777980"))
              .font(.pretendard(14, .regular))
            
            VStack(alignment: .leading, spacing: 8) {
              HStack(spacing: 6) {
                Image(R.Images.check)
                  .foregroundColor(Color(hex: "FF704D"))
                Text("연락이 잘 돼요")
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
          Text("포트폴리오 링크")
            .foregroundColor(Color(hex: "777980"))
            .font(.pretendard(14, .regular))
          
          HStack {
            Image(R.Images.link)
              .foregroundColor(Color(hex: "FE6F53"))
            Text("C:/Users/example/Downloads...")
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
                                    userInfo: ["id": first.id, "rightSwipe": rightSwipe]
    )
  }
}

extension View {
  func getRect() -> CGRect { UIScreen.main.bounds }
}
