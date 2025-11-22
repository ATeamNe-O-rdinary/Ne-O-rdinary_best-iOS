import SwiftUI

struct MyProfileView: View {
  var body: some View {
    VStack {
      Text("링크팅")
        .font(.pretendard(16, .semibold))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      ScrollView {
        VStack(alignment: .leading, spacing: 28) {
          
          // MARK: - 1) 상단 인사/소개 텍스트
          Text("스타트업 근무 중인 프론트엔드 개발자입니다.")
            .font(.pretendard(16, .regular))
            .foregroundColor(Color(hex: "4A4A4A"))
            .padding(.top, 4)
          
          // MARK: - 2) 프로필 카드
          profileCard
          
          // MARK: - 3) 프로필 완성도 + 버튼
          completionSection
          
          // MARK: - 4) "나를 선택한 기업" 섹션 타이틀
          Text("나를 선택한 기업")
            .font(.pretendard(18, .semibold))
            .foregroundColor(.black)
          
          // MARK: - 5) 기업 카드 두 개
          companyCards
          
          Spacer()
        }
        .padding(.top, 8)
        .background(Color.white)
      }
    }
    .padding(.horizontal, 26)
  }
  
  // MARK: - 프로필 카드
  private var profileCard: some View {
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
        Text("웹 제작 · 3년차")
          .font(.pretendard(14, .regular))
          .foregroundColor(Color(hex: "666666"))
      }
      
      Spacer()
    }
    .padding(16)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.white)
        .shadow(color: Color.black.opacity(0.07), radius: 8, x: 0, y: 2)
    )
  }
  
  // MARK: - 프로필 완성도
  private var completionSection: some View {
    VStack(alignment: .leading, spacing: 16) {
      
      HStack {
        Text("프로필 완성도 50%")
          .font(.pretendard(14, .medium))
          .foregroundColor(.black)
        
        Spacer()
        
        Text("정보 수정")
          .font(.pretendard(14, .medium))
          .padding(.horizontal, 12)
          .padding(.vertical, 6)
          .foregroundColor(.black)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .stroke(Color(hex: "DDDDDD"), lineWidth: 1)
          )
      }
      
      // Progress Bar
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color(hex: "E6E6E6"))
          .frame(height: 8)
        
        RoundedRectangle(cornerRadius: 10)
          .fill(Color(hex: "FF6A3D"))
          .frame(width: 120, height: 8)  // 50% 정도
      }
    }
  }
  
  
  // MARK: - 기업 카드 2개
  private var companyCards: some View {
    HStack(spacing: 12) {
      companyCard(
        image: "company_img1",
        title: "IT/미디어",
        company: "링크럽",
        badge: "제안"
      )
      companyCard(
        image: "company_img2",
        title: "뷰티/패션",
        company: "뷰티기업",
        badge: "제안"
      )
    }
  }
  
  
  // 기업 카드 재사용 컴포넌트
  private func companyCard(image: String, title: String, company: String, badge: String) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Image("User1") // 임시
        .resizable()
        .frame(height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 16))
      
      Text(title)
        .font(.pretendard(12, .medium))
        .foregroundColor(Color(hex: "999999"))
      
      Text(company)
        .font(.pretendard(16, .semibold))
        .foregroundColor(.black)
      
      HStack {
        Spacer()
        Text("받기")
          .font(.pretendard(14, .medium))
          .padding(.vertical, 6)
          .padding(.horizontal, 16)
          .background(Color(hex: "FF6A3D"))
          .foregroundColor(.white)
          .clipShape(RoundedRectangle(cornerRadius: 10))
      }
    }
    .padding(12)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.white)
        .shadow(color: Color.black.opacity(0.07), radius: 6, x: 0, y: 4)
    )
  }
}

#Preview {
  MyProfileView()
}
