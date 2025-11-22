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
          .frame(width: size.width - topOffset, height: size.height)
          .clipShape(.rect(cornerRadius: 15))
          .offset(y: -topOffset)
        
        // --- 카드 뒷면 ---
        backCard(size: size, topOffset: topOffset)
          .opacity(isFlipped ? 1 : 0)
          .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
          .frame(width: size.width - topOffset, height: size.height)
          .clipShape(.rect(cornerRadius: 15))
          .offset(y: -topOffset)
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
    VStack(spacing: 18) {
      ZStack {
        Image(user.profilePic)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: size.width)
          .frame(height: 228)
      }
      .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
      
      VStack(alignment: .leading, spacing: 20) {
        VStack(alignment: .leading, spacing: 12) {
          VStack(alignment: .leading) {
            Text("한줄소개")
              .frame(maxWidth: .infinity, alignment: .leading)
            Text("스타트업 근무 중인 프론트엔드 개발자입니다")
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          Divider()
          
          VStack(alignment: .leading) {
            HStack(spacing: 12) {
              Text("업무 방식")
              Text("풀타임 가능")
            }
            
            HStack(spacing: 12) {
              Text("희망 단가")
              HStack(spacing: 2) {
                Text("80,000원")
                Text("건당")
              }
            }
            
            HStack(spacing: 12) {
              Text("선호 지역")
              Text("서울")
            }
          }
          .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        HStack(spacing: 4) {
          ForEach(["웹 퍼블리싱", "반응형", "React"], id: \.self) { tag in
              TagChip(text: tag)
          }
        }
      }
      .frame(maxWidth: .infinity)
      .padding(26)
    }
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    )
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
