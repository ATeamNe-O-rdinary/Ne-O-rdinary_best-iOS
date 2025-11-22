import SwiftUI

struct MyProfileView: View {
  @State private var showDialog = false   // 👈 추가
  @State private var showMessageDialog = false   // 👈 추가
  
  var body: some View {
    VStack {
      Text("링크팅")
        .font(.pretendard(16, .semibold))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 26)
      
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading, spacing: 28) {
          // MARK: - 1) 상단 인사/소개 텍스트
          VStack(spacing: 52) {
            VStack(spacing: 38) {
              VStack(spacing: 12) {
                HStack(spacing: 4) {
                  Image(R.Images.myImage)
                  
                  Text("스타트업 근무 중인 프론트엔드 개발자입니다.")
                    .font(.pretendard(16, .semibold))
                    .foregroundColor(Color(hex: "414245"))
                    .frame(maxWidth: .infinity)
                }
                
                // MARK: - 2) 프로필 카드
                profileCard
              }
              .padding(.horizontal, 26)
              
              HStack {
                VStack(spacing: 26) {
                  Circle()
                    .frame(width: 43, height: 43)
                  Text("링크한 기업")
                    .font(.pretendard(14, .medium))
                    .foregroundStyle(Color.black)
                }
                Spacer()
                VStack(spacing: 26) {
                  Circle()
                    .frame(width: 43, height: 43)
                  Text("링크한 기업")
                    .font(.pretendard(14, .medium))
                    .foregroundStyle(Color.black)
                }
                Spacer()
                VStack(spacing: 26) {
                  Circle()
                    .frame(width: 43, height: 43)
                  Text("링크한 기업")
                    .font(.pretendard(14, .medium))
                    .foregroundStyle(Color.black)
                }
              }
              .padding(.horizontal, 20)
            }
            .frame(maxWidth: .infinity)
            
            Divider()
              .overlay {
                Color(hex: "EAECEE")
                  .frame(height: 8)
              }
          }
          
          // MARK: - 4) "나를 선택한 기업" 섹션 타이틀
          VStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 20) {
              Text("나를 선택한 기업")
                .font(.pretendard(18, .semibold))
                .foregroundColor(.black)
              
              HStack {
                VStack(alignment: .leading, spacing: 8) {
                  Text("나에게 관심을 보이는 기업에게 회신하기")
                    .font(.pretendard(15, .semibold))
                    .foregroundColor(Color(hex: "333333"))
                  Text("응답하면 매칭율이 높아져요!")
                    .font(.pretendard(12, .medium))
                    .foregroundColor(Color(hex: "777980"))
                }
                Spacer()
                Image(R.Images.mail)
              }
              .padding(.leading, 16)
              .background(Color(hex: "F1F1F2"))
              .clipShape(.rect(cornerRadius: 12))
            }
            .padding(.horizontal, 26)
            
            // MARK: - 5) 기업 카드 두 개
            companyCards
          }
        }
        .padding(.bottom, 20)
        .background(Color.white)
      }
    }
    .fullScreenCover(isPresented: $showDialog) {
      LinkerDialog(
        onClose: { showDialog = false },
        onSendLink: {
          print("링크톡 보내기")
          showDialog = false
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            showMessageDialog = true
          }
        }
      )
      .ignoresSafeArea()
    }
    .transaction({ transaction in
      transaction.disablesAnimations = true
    })
    .fullScreenCover(isPresented: $showMessageDialog) {
      LinkerDialog2(
        onClose: { showMessageDialog = false },
        onSendLink: {
          print("링크톡 보내기")
          showMessageDialog = false
        }
      )
      .ignoresSafeArea()
    }
    .transaction({ transaction in
      transaction.disablesAnimations = true
    })
  }
  
  // MARK: - 프로필 카드
  private var profileCard: some View {
    VStack {
      HStack(spacing: 12) {
        
        Image("User1")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 66, height: 66)
          .clipShape(RoundedRectangle(cornerRadius: 12))
        
        VStack(alignment: .leading, spacing: 6) {
          
          // 링커 태그 + 이름
          HStack(spacing: 6) {
            Text("링커")
              .font(.pretendard(12, .medium))
              .padding(.horizontal, 8)
              .padding(.vertical, 4)
              .background(Color(hex: "FFF0E9"))
              .foregroundColor(Color(hex: "FF6A3D"))
              .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Text("홍길동")
              .font(.pretendard(16, .semibold))
              .foregroundColor(.black)
          }
          
          // 직무 + 경력
          HStack {
            Image(R.Images.link)
            
            Text("웹 제작 · 3년차")
              .font(.pretendard(14, .regular))
              .foregroundColor(Color(hex: "666666"))
          }
        }
        
        Spacer()
      }
      .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
      
      Divider()
      
      HStack {
        HStack {
          Text("프로필 완성률 ")
            .font(.pretendard(14, .medium))
            .foregroundColor(Color(hex: "777980"))
          Text("50%")
            .font(.pretendard(14, .semibold))
            .foregroundColor(Color(hex: "222222"))
        }
        Spacer()
        Text("정보 수정")
          .font(.pretendard(12, .medium))
          .foregroundColor(Color(hex: "888888"))          // 글자 색
          .padding(.vertical, 9)
          .padding(.horizontal, 18)
          .background(
            Capsule()
              .fill(Color.white)                  // 안쪽 흰색
              .overlay(
                Capsule()
                  .stroke(Color(hex: "F3EFEF"), lineWidth: 1) // 옅은 테두리
              )
          )
      }
      .padding(EdgeInsets(top: 4, leading: 12, bottom: 12, trailing: 12))
    }
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.white)
        .overlay(
          RoundedRectangle(cornerRadius: 12)
            .stroke(Color(hex: "EAECEE"), lineWidth: 1)
        )
    )
  }
  
  // MARK: - 기업 카드 2개
  private var companyCards: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 8) {
        companyCard(
          image: "company_img1",
          title: "IT/미디어",
          company: "링크럽"
        )
        companyCard(
          image: "company_img2",
          title: "뷰티/패션",
          company: "뷰티기업"
        )
        companyCard(
          image: "company_img3",
          title: "뷰티/패션",
          company: "뷰티기업"
        )
      }
      .padding(.leading, 26)
    }
  }
  
  
  // 기업 카드 재사용 컴포넌트
  private func companyCard(image: String, title: String, company: String) -> some View {
    ZStack(alignment: .bottomLeading) {
      // MARK: - Background Image
      Image(image)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 172, height: 230)
        .overlay(
          // MARK: - Gradient Overlay
          Color.black.opacity(0.56)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        )
      
      // MARK: - Text + Buttons
      VStack(alignment: .leading, spacing: 8) {
        VStack(alignment: .leading, spacing: 2) {
          Text(title)
            .font(.pretendard(13, .medium))
            .foregroundColor(Color(hex: "ffffff"))
          
          Text(company)
            .font(.pretendard(16, .semibold))
            .foregroundColor(Color(hex: "ffffff"))
        }
        
        HStack {
          // 거절 버튼
          Text("거절")
            .font(.pretendard(14, .medium))
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.8))
            .foregroundColor(Color(hex: "9D9FA1"))
            .clipShape(RoundedRectangle(cornerRadius: 6))
          
          Spacer()
          
          // 받기 버튼
          Button {
            showDialog = true
          } label: {
            Text("받기")
              .font(.pretendard(14, .medium))
              .padding(.vertical, 8)
              .padding(.horizontal, 18)
              .frame(maxWidth: .infinity)
              .background(.white)
              .foregroundColor(Color(hex: "FF704D"))
              .clipShape(RoundedRectangle(cornerRadius: 6))
          }
        }
      }
      .padding(10)
    }
    .frame(width: 172, height: 230)
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}

#Preview {
  MyProfileView()
}

struct BackgroundBlurView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIView {
    let view = UIView()
    DispatchQueue.main.async {
      view.superview?.superview?.backgroundColor = .clear
    }
    return view
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
}

struct LinkerDialog: View {
  let onClose: () -> Void
  let onSendLink: () -> Void
  
  var body: some View {
    ZStack {
      // dim
      Color.black.opacity(0.4)
        .ignoresSafeArea()
        .onTapGesture {
          onClose()
        }
      
      // dialog
      VStack(spacing: 20) {
        
        Text("👏")
          .font(.system(size: 40))
        
        VStack(spacing: 6) {
          Text("축하합니다, 링커님!")
            .font(.pretendard(16, .medium))
            .foregroundColor(Color(hex: "333333"))
          
          Text("링오님과 연결됐어요")
            .font(.pretendard(16, .medium))
            .foregroundColor(Color(hex: "333333"))
        }
        
        HStack(spacing: 12) {
          Button(action: onClose) {
            Text("닫기")
              .font(.pretendard(15, .medium))
              .frame(maxWidth: .infinity)
              .padding(.vertical, 12)
              .background(Color(hex: "F3F3F4"))
              .foregroundColor(Color(hex: "333333"))
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
          
          Button(action: onSendLink) {
            Text("링크톡 보내기")
              .font(.pretendard(15, .medium))
              .frame(maxWidth: .infinity)
              .padding(.vertical, 12)
              .background(Color(hex: "FF6A3D"))
              .foregroundColor(.white)
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
        }
      }
      .padding(26)
      .frame(width: 310)
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .shadow(color: Color.black.opacity(0.15), radius: 16, x: 0, y: 6)
      .transition(.scale.combined(with: .opacity))
      .animation(.spring(response: 0.35, dampingFraction: 0.7), value: true)
    }
    .background(BackgroundBlurView())
  }
}

struct LinkerDialog2: View {
  let onClose: () -> Void
  let onSendLink: () -> Void
  
  var body: some View {
    ZStack {
      // dim
      Color.black.opacity(0.4)
        .ignoresSafeArea()
        .onTapGesture {
          onClose()
        }
      
      // dialog
      VStack(spacing: 20) {
        
        Text("🖤")
          .font(.system(size: 40))
        
        VStack(spacing: 6) {
          Text("링오에게 메시지를 보냈어요")
            .font(.pretendard(16, .medium))
            .foregroundColor(Color(hex: "333333"))
        }
        
        HStack(spacing: 12) {
          Button(action: onClose) {
            Text("닫기")
              .font(.pretendard(15, .medium))
              .frame(maxWidth: .infinity)
              .padding(.vertical, 12)
              .background(Color(hex: "F3F3F4"))
              .foregroundColor(Color(hex: "333333"))
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
        }
      }
      .padding(26)
      .frame(width: 310)
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .shadow(color: Color.black.opacity(0.15), radius: 16, x: 0, y: 6)
      .transition(.scale.combined(with: .opacity))
      .animation(.spring(response: 0.35, dampingFraction: 0.7), value: true)
    }
    .background(BackgroundBlurView())
  }
}
