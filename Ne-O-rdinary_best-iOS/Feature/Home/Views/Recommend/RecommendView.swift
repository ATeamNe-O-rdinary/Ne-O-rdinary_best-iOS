import SwiftUI

struct RecommendView: View {
  
  let categories = ["웹 제작", "앱 제작", "게임 개발", "AI", "서버 구축"]
  
  // 샘플 데이터
  let candidates = Array(0..<10)    // 10개 카드 예시
  
  // 2열 그리드 설정
  private let columns = [
    GridItem(.flexible(), spacing: 16),
    GridItem(.flexible(), spacing: 16)
  ]
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        
        // 🔥 태그
        categorySection
        
        // 🔥 섹션 타이틀
        Text("지금 많이 찾는 지원자예요! 🔥")
          .font(.pretendard(20, .semibold))
          .foregroundColor(.black)
          .padding(.horizontal, 16)
        
        // 🔥 2열 그리드 카드
        LazyVGrid(columns: columns, spacing: 20) {
          ForEach(candidates, id: \.self) { _ in
            candidateCard
          }
        }
        .padding(.horizontal, 16)
        
        Spacer()
      }
      .padding(.top, 16)
    }
    .background(Color.white)
  }
  
  
  // MARK: - 카테고리 태그
  private var categorySection: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 12) {
        ForEach(categories, id: \.self) { text in
          categoryChip(text)
        }
      }
      .padding(.horizontal, 16)
    }
  }
  
  private func categoryChip(_ text: String) -> some View {
    Text(text)
      .font(.pretendard(14, .medium))
      .padding(.vertical, 8)
      .padding(.horizontal, 18)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(text == "앱 제작" ? Color(hex: "FFF0E9") : Color(hex: "F5F5F5"))
      )
      .foregroundColor(text == "앱 제작" ? Color(hex: "FF6A3D") : Color(hex: "757575"))
  }
  
  
  // MARK: - 지원자 카드
  private var candidateCard: some View {
    VStack(alignment: .leading, spacing: 0) {
      Image("User1")
        .resizable()
        .aspectRatio(1.0, contentMode: .fill)
        .frame(height: 140)
        .clipShape(RoundedRectangle(cornerRadius: 12))
      
      VStack(alignment: .leading, spacing: 4) {
        Text("프론트엔드")
          .font(.pretendard(14, .medium))
          .foregroundColor(Color(hex: "FF6A3D"))
        
        Text("김ㅇㅇ")
          .font(.pretendard(18, .semibold))
          .foregroundColor(.black)
      }
      .padding(12)
    }
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.white)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    )
  }
}

#Preview {
  RecommendView()
}
