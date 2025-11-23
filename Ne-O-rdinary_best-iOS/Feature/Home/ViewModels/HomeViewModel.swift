//
//  HomeViewModel.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
  @Published var fetcedUsers: [ProjectProfile] = []
  
  @Published var displayingUsers: [ProjectProfile]?
  
  init() {
    fetcedUsers = [
      
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
          rateAmount: 120,
          collaborationType: .both,
          region: "INCHEON",
          deadline: "2025-10-01",
          techStacks: [.reactNative, .flutter, .java],
          profileImage: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/d76546d1-4568-4329-8825-3ddf0e252d18.png"
      ),
      
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
          linkoId: "5",
          companyName: "AI 솔루션 랩",
          companyType: "IT_PROGRAMMING",
          mainCategory: "IT_PROGRAMMING",
          categoryOfBusiness: "AI_DEV",
          projectIntro: "AI 모델 학습용 데이터 파이프라인 개발 프로젝트입니다.",
          expectedDuration: "4개월",
          rateUnit: "HOURLY",
          rateAmount: 700,
          collaborationType: .both,
          region: "DAEJEON",
          deadline: "2026-01-15",
          techStacks: [.reactNative, .flutter, .java],
          profileImage: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/f6fff1f9-30f6-491d-86b8-467e99b0565e.png"
      ),
    ]
  
    displayingUsers = fetcedUsers
  }
  
  func getIndex(user: ProjectProfile) -> Int {
    let index = displayingUsers?.firstIndex(where: { currentUser in
      return user.linkoId == currentUser.linkoId
    }) ?? 0
    
    return index
  }
  
  func fetchList() async {
    do {
      let result = try await HomeClient.shared.fetchProfiles(
        type: .project
      )

      if let memberList = result as? [ProjectProfile] {
          print(memberList)
      }
    } catch {
      Logger.e("\(error)")
    }
  }
}
