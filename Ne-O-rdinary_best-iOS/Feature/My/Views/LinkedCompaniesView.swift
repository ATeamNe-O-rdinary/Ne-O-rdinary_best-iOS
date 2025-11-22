import SwiftUI

struct LinkedCompaniesView: View {
    
    // 샘플 데이터 —— 실제 API 연결 시 이 부분만 바꿔주면 됨
    let companies: [LinkedCompany] = [
        LinkedCompany(title: "모바일 앱 개발자 (Flutter)", companyName: "(주) 링크틴", logo: "company_img1"),
        LinkedCompany(title: "모바일 앱 개발자 (Flutter)", companyName: "(주) 링크틴", logo: "company_img2"),
        LinkedCompany(title: "모바일 앱 개발자 (Flutter)", companyName: "(주) 링크틴", logo: "company_img3")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 22) {
                ForEach(companies) { company in
                    companyRow(company)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .background(Color.white)
    }
    
    // MARK: - Row UI
    private func companyRow(_ company: LinkedCompany) -> some View {
        HStack(spacing: 16) {
            
            // 왼쪽 회사 이미지
            Image(company.logo)
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            // 가운데 텍스트
            VStack(alignment: .leading, spacing: 6) {
                Text(company.title)
                    .font(.pretendard(15, .medium))
                    .foregroundStyle(Color.black)
                
                Text(company.companyName)
                    .font(.pretendard(13, .regular))
                    .foregroundStyle(Color(hex: "777980"))
            }
            
            Spacer()
            
            // 오른쪽 버튼 (돋보기 UI)
            Button(action: {
                print("돋보기 클릭")
            }) {
              Image(R.Images.link)
                .renderingMode(.template)
                .foregroundColor(Color(hex: "777980"))
                    .frame(width: 34, height: 34)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
            }
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Model
struct LinkedCompany: Identifiable {
    let id = UUID()
    let title: String
    let companyName: String
    let logo: String
}

#Preview {
    LinkedCompaniesView()
}
