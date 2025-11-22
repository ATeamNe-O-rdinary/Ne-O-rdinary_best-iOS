import SwiftUI
import Kingfisher

struct RecommendView: View {
  let newProjects: [ProjectProfile] = [

      ProjectProfile(
          linkoId: "10",
          companyName: "네오링크",
          companyType: "IT_PROGRAMMING",
          mainCategory: "IT_PROGRAMMING",
          categoryOfBusiness: "APP_DEV",
          projectIntro: "MVP 모바일 앱 개발",
          expectedDuration: "3개월",
          rateUnit: "HOURLY",
          rateAmount: 60,
          collaborationType: .both,
          region: "SEOUL",
          deadline: "2025-09-10",
          techStacks: [.swift, .nodeJS, .reactNative],
          profileImage: "https://picsum.photos/300/200?random=10"
      ),

      ProjectProfile(
          linkoId: "11",
          companyName: "오로라랩",
          companyType: "DESIGN",
          mainCategory: "DESIGN",
          categoryOfBusiness: "LOGO_BRANDING",
          projectIntro: "브랜드 BI 리뉴얼",
          expectedDuration: "1개월",
          rateUnit: "PER_CASE",
          rateAmount: 120,
          collaborationType: .both,
          region: "GANGNEUNG",
          deadline: "2025-11-01",
          techStacks: [.swift, .java],
          profileImage: "https://picsum.photos/300/200?random=11"
      ),

      ProjectProfile(
          linkoId: "12",
          companyName: "픽셀코드",
          companyType: "IT_PROGRAMMING",
          mainCategory: "IT_PROGRAMMING",
          categoryOfBusiness: "WEB_DEV",
          projectIntro: "프론트엔드 웹 리뉴얼",
          expectedDuration: "2개월",
          rateUnit: "HOURLY",
          rateAmount: 45,
          collaborationType: .both,
          region: "BUSAN",
          deadline: "2025-10-21",
          techStacks: [.reactNative, .flutter],
          profileImage: "https://picsum.photos/300/200?random=12"
      ),

      ProjectProfile(
          linkoId: "13",
          companyName: "그라운드업 스튜디오",
          companyType: "MARKETING",
          mainCategory: "MARKETING",
          categoryOfBusiness: "SNS_OPERATION",
          projectIntro: "브랜드 SNS 기획·운영",
          expectedDuration: "6개월",
          rateUnit: "MONTHLY",
          rateAmount: 150,
          collaborationType: .both,
          region: "INCHEON",
          deadline: "2025-08-05",
          techStacks: [.java],
          profileImage: "httpsum.photos/300/200?random=13"
      ),

      ProjectProfile(
          linkoId: "14",
          companyName: "알파랩",
          companyType: "IT_PROGRAMMING",
          mainCategory: "AI",
          categoryOfBusiness: "AI_DEV",
          projectIntro: "AI 챗봇 모델 고도화",
          expectedDuration: "4개월",
          rateUnit: "HOURLY",
          rateAmount: 90000,
          collaborationType: .both,
          region: "DAEJEON",
          deadline: "2026-01-15",
          techStacks: [.pythonDjangoFastAPI, .java],
          profileImage: "https://picsum.photos/300/200?random=14"
      ),

      ProjectProfile(
          linkoId: "15",
          companyName: "센트럴소프트",
          companyType: "IT_PROGRAMMING",
          mainCategory: "IT_PROGRAMMING",
          categoryOfBusiness: "APP_DEV",
          projectIntro: "기존 앱 유지보수/리팩토링",
          expectedDuration: "2개월",
          rateUnit: "HOURLY",
          rateAmount: 40,
          collaborationType: .both,
          region: "GWANGJU",
          deadline: "2025-12-22",
          techStacks: [.swift, .kotlin],
          profileImage: "https://picsum.photos/300/200?random=15"
      ),

      ProjectProfile(
          linkoId: "16",
          companyName: "뉴웨이브",
          companyType: "MARKETING",
          mainCategory: "MARKETING",
          categoryOfBusiness: "SNS_OPERATION",
          projectIntro: "틱톡 숏폼 캠페인 제작",
          expectedDuration: "1개월",
          rateUnit: "PER_CASE",
          rateAmount: 100,
          collaborationType: .both,
          region: "SEOUL",
          deadline: "2025-07-01",
          techStacks: [.reactNative],
          profileImage: "https://picsum.photos/300/200?random=16"
      ),

      ProjectProfile(
          linkoId: "17",
          companyName: "인사이트랩",
          companyType: "IT_PROGRAMMING",
          mainCategory: "IT_PROGRAMMING",
          categoryOfBusiness: "WEB_DEV",
          projectIntro: "사내관리 백오피스 개발",
          expectedDuration: "4개월",
          rateUnit: "MONTHLY",
          rateAmount: 350,
          collaborationType: .both,
          region: "SEOUL",
          deadline: "2025-12-20",
          techStacks: [.nodeJS, .springJava],
          profileImage: "https://picsum.photos/300/200?random=17"
      ),

      ProjectProfile(
          linkoId: "18",
          companyName: "루미너스게임즈",
          companyType: "IT_PROGRAMMING",
          mainCategory: "IT_PROGRAMMING",
          categoryOfBusiness: "GAME_CLIENT",
          projectIntro: "캐주얼 게임 신규 개발",
          expectedDuration: "6개월",
          rateUnit: "HOURLY",
          rateAmount: 55,
          collaborationType: .both,
          region: "BUSAN",
          deadline: "2026-02-11",
          techStacks: [.java, .reactNative],
          profileImage: "https://picsum.photos/300/200?random=18"
      ),

      ProjectProfile(
          linkoId: "19",
          companyName: "디지털하이브",
          companyType: "DESIGN",
          mainCategory: "DESIGN",
          categoryOfBusiness: "LOGO_BRANDING",
          projectIntro: "앱 온보딩 일러스트 제작",
          expectedDuration: "1개월",
          rateUnit: "PER_CASE",
          rateAmount: 90,
          collaborationType: .both,
          region: "DAEGU",
          deadline: "2025-09-10",
          techStacks: [.swift],
          profileImage: "https://picsum.photos/300/200?random=19"
      )
  ]
  
  let projects: [ProjectProfile] = [
    
    ProjectProfile(
        linkoId: "1",
        companyName: "링크팅",
        companyType: "IT_PROGRAMMING",
        mainCategory: "IT_PROGRAMMING",
        categoryOfBusiness: "WEB_DEV",
        projectIntro: "모바일 앱 개발자 (Flutter)",
        expectedDuration: "1개월",
        rateUnit: "HOURLY",
        rateAmount: 50,
        collaborationType: .both,
        region: "SEOUL",
        deadline: "2025-12-31",
        techStacks: [.reactNative, .flutter, .java, .nodeJS, .swift],
        profileImage: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/42f9490f-86bb-48a8-a689-2defc80c84cc.png"
    ),

    ProjectProfile(
        linkoId: "2",
        companyName: "CMC",
        companyType: "MARKETING",
        mainCategory: "DESIGN",
        categoryOfBusiness: "LOGO_BRANDING",
        projectIntro: "브랜드 로고 및 패키지 리뉴얼 작업입니다.",
        expectedDuration: "1개월",
        rateUnit: "PER_CASE",
        rateAmount: 80,
        collaborationType: .both,
        region: "GYEONGGI",
        deadline: "2025-11-15",
        techStacks: [.nodeJS, .swift, .kotlin, .pythonDjangoFastAPI, .springJava],
        profileImage: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/9ae7176a-269c-4d0d-8cfd-5678742854ab.png"
    ),

    ProjectProfile(
        linkoId: "3",
        companyName: "UMC",
        companyType: "IT_PROGRAMMING",
        mainCategory: "IT_PROGRAMMING",
        categoryOfBusiness: "APP_DEV",
        projectIntro: "iOS 앱 신규 기능 개발 및 UI 개선 작업입니다.",
        expectedDuration: "2개월",
        rateUnit: "HOURLY",
        rateAmount: 30,
        collaborationType: .both,
        region: "BUSAN",
        deadline: "2025-12-10",
        techStacks: [.reactNative, .flutter, .java],
        profileImage: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/c448066f-a703-4638-b903-d6aa1d1adbbd.png"
    ),

    ProjectProfile(
        linkoId: "4",
        companyName: "버즈빌",
        companyType: "MARKETING",
        mainCategory: "MARKETING",
        categoryOfBusiness: "SNS_OPERATION",
        projectIntro: "SNS 운영 및 콘텐츠 제작 프로젝트입니다.",
        expectedDuration: "6개월",
        rateUnit: "MONTHLY",
        rateAmount: 1200000,
        collaborationType: .both,
        region: "INCHEON",
        deadline: "2025-10-01",
        techStacks: [.reactNative, .flutter, .java],
        profileImage: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/d76546d1-4568-4329-8825-3ddf0e252d18.png"
    ),

    ProjectProfile(
        linkoId: "5",
        companyName: "AI 솔루션 랩",
        companyType: "IT_PROGRAMMING",
        mainCategory: "IT_PROGRAMMING",
        categoryOfBusiness: "AI_DEV",
        projectIntro: "AI 모델 학습용 데이터 파이프라인 개발 프로젝트입니다.",
        expectedDuration: "4개월",
        rateUnit: "HOURLY",
        rateAmount: 70000,
        collaborationType: .both,
        region: "DAEJEON",
        deadline: "2026-01-15",
        techStacks: [.reactNative, .flutter, .java],
        profileImage: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/f6fff1f9-30f6-491d-86b8-467e99b0565e.png"
    )]
  let categories = ["웹 제작", "앱 제작", "게임 개발", "AI", "서버 구축"]
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading, spacing: 28) {
        
        // MARK: 카테고리 선택
        categorySection
        
        // MARK: 많이 찾는 기업
        sectionTitle("지금 많이 찾는 기업이에요! 🔥")
        
        horizontalCompanyScroll(projects)
        
        // MARK: 신규 기업
        sectionTitle("신규 기업을 보여드려요 😃")
        
        horizontalCompanyScroll(newProjects)
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
  private func horizontalCompanyScroll(_ data: [ProjectProfile]) -> some View {
      ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 14) {
              ForEach(data) { project in
                  companyCard(project)
              }
          }
          .padding(.horizontal, 20)
      }
  }
  
  
  // MARK: - 회사 카드 (ProjectProfile 기반)
  private func companyCard(_ project: ProjectProfile) -> some View {
      VStack(alignment: .leading, spacing: 0) {
          
          // 🔥 대표 이미지
          KFImage(URL(string: project.profileImage))
              .placeholder {
                  Color.gray.opacity(0.2)
              }
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 150, height: 130)
              .clipShape(RoundedRectangle(cornerRadius: 12))
              .clipped()
          
          // 🔥 텍스트 영역
          VStack(alignment: .leading, spacing: 4) {
              
              Text(project.companyName)
                  .font(.pretendard(13, .medium))
                  .foregroundColor(Color(hex: "555555"))
                  .lineLimit(1)
              
              Text(project.projectIntro)
                  .font(.pretendard(16, .semibold))
                  .foregroundColor(.black)
                  .lineLimit(1)
              
              Text("\(project.rateAmount)만원")    // 금액
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
