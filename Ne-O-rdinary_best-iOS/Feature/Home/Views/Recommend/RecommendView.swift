import SwiftUI

struct RecommendView: View {
  
  let categories = ["웹 제작", "앱 제작", "게임 개발", "AI", "서버 구축"]
  
  let companies = Array(0..<10)
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading, spacing: 28) {
        
        // MARK: 카테고리 선택
        categorySection
        
        // MARK: 많이 찾는 기업
        sectionTitle("지금 많이 찾는 기업이에요! 🔥")
        
        horizontalCompanyScroll
        
        // MARK: 신규 기업
        sectionTitle("신규 기업을 보여드려요 😃")
        
        horizontalCompanyScroll
      }
      .padding(.top, 12)
      .padding(.bottom, 20)
    }
    .background(Color.white)
  }
  
  // MARK: - 카테고리 선택
  private var categorySection: some View {
    VStack(alignment: .leading, spacing: 14) {
      Text("카테고리 선택")
        .font(.pretendard(16, .semibold))
        .padding(.horizontal, 20)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 12) {
          ForEach(categories, id: \.self) { text in
            categoryChip(text)
          }
        }
        .padding(.horizontal, 20)
      }
    }
  }
  
  private func categoryChip(_ text: String) -> some View {
    Text(text)
      .font(.pretendard(14, .medium))
      .padding(.vertical, 6)
      .padding(.horizontal, 16)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(text == "앱 제작" ? Color(hex: "FFF0E9") : Color(hex: "F5F5F5"))
      )
      .foregroundColor(text == "앱 제작" ? Color(hex: "FF6A3D") : Color(hex: "757575"))
  }
  
  
  // MARK: - 섹션 타이틀
  private func sectionTitle(_ title: String) -> some View {
    Text(title)
      .font(.pretendard(18, .semibold))
      .foregroundColor(.black)
      .padding(.horizontal, 20)
  }
  
  
  // MARK: - 가로 스크롤 카드 리스트
  private var horizontalCompanyScroll: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 14) {
        ForEach(companies, id: \.self) { _ in
          companyCard
        }
      }
      .padding(.horizontal, 20)
    }
  }
  
  
  // MARK: - 회사 카드 (시안 스타일 그대로)
  private var companyCard: some View {
    VStack(alignment: .leading, spacing: 0) {
      
      Image("company_img1")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 150, height: 130)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .clipped()
      
      VStack(alignment: .leading, spacing: 4) {
        Text("(주) 링크딩")
          .font(.pretendard(13, .medium))
          .foregroundColor(Color(hex: "555555"))
        
        Text("모바일 앱 개발자")
          .font(.pretendard(16, .semibold))
          .foregroundColor(.black)
        
        Text("50만원")
          .font(.pretendard(14, .semibold))
          .foregroundColor(Color(hex: "FF6A3D"))
          .padding(.top, 2)
      }
      .padding(12)
    }
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.white)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    )
    .frame(width: 150)
  }
}

#Preview {
  RecommendView()
}
