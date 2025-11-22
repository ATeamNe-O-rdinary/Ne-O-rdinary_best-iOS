import SwiftUI
import Kingfisher

struct LinkedCompaniesView: View {
    
    // 샘플 데이터 —— 실제 API 연결 시 이 부분만 바꿔주면 됨
  let companies: [LinkedCompany] = [
      LinkedCompany(title: "모바일 앱 개발자 (Flutter)", companyName: "(주) 링크틴", logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/42f9490f-86bb-48a8-a689-2defc80c84cc.png"),
      LinkedCompany(title: "웹사이트 리뉴얼 프론트엔드", companyName: "블루웨이브소프트", logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/9ae7176a-269c-4d0d-8cfd-5678742854ab.png"),
      LinkedCompany(title: "SNS 콘텐츠 제작자", companyName: "트렌디마케팅랩", logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/c448066f-a703-4638-b903-d6aa1d1adbbd.png"),
      LinkedCompany(title: "iOS 앱 UI/UX 디자이너", companyName: "크리에이티브픽셀", logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/d76546d1-4568-4329-8825-3ddf0e252d18.png"),
      LinkedCompany(title: "브랜딩 패키지 디자이너", companyName: "오렌지브랜드랩", logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/f6fff1f9-30f6-491d-86b8-467e99b0565e.png"),
      LinkedCompany(title: "Node.js 백엔드 개발자", companyName: "포타랩스", logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/42f9490f-86bb-48a8-a689-2defc80c84cc.png"),
      LinkedCompany(title: "React 웹 퍼블리셔", companyName: "그로쓰디지털", logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/9ae7176a-269c-4d0d-8cfd-5678742854ab.png"),
      LinkedCompany(title: "AI 데이터 파이프라인 엔지니어", companyName: "AI 솔루션 랩", logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/c448066f-a703-4638-b903-d6aa1d1adbbd.png"),
      LinkedCompany(title: "안드로이드 앱 개발자", companyName: "UMC 테크", logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/d76546d1-4568-4329-8825-3ddf0e252d18.png"),
      LinkedCompany(title: "브랜드 SNS 광고 기획", companyName: "댄디마케팅그룹", logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/f6fff1f9-30f6-491d-86b8-467e99b0565e.png")
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
          KFImage(URL(string: company.logo))
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
