//
//  HomeViewModel.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
  @Published var fetcedUsers: [MemberProfile] = []
  
  @Published var displayingUsers: [MemberProfile]?
  
  init() {
    fetcedUsers = [
      MemberProfile(linkerId: "1", nickname: "happy", careerLevel: .junior, workTimeType: .anytime, rateUnit: .hourly, collaborationType: .both, region: .anywhere, techStacks: [.flutter, .java, .kotlin], categoryOfBusiness: .aiDev, jobCategory: "WEB_DEV", oneLineDescription: "5년차 백엔드 개발자입니다. 대용량 트래픽 처리 경험 다수.", rateAmount: 500000, profileImage: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/profile/ecf63421-e2e1-402e-bf9b-a74bf1959dbf.jpg"),
      
      MemberProfile(linkerId: "2", nickname: "happy", careerLevel: .junior, workTimeType: .anytime, rateUnit: .hourly, collaborationType: .both, region: .anywhere, techStacks: [.flutter, .java, .kotlin], categoryOfBusiness: .aiDev, jobCategory: "WEB_DEV", oneLineDescription: "5년차 백엔드 개발자입니다. 대용량 트래픽 처리 경험 다수.", rateAmount: 500000, profileImage: "https://s3.ap-northeast-2.amazonaws.com/bucket/linker-profile/456.png"),
      
      MemberProfile(linkerId: "3", nickname: "happy", careerLevel: .junior, workTimeType: .anytime, rateUnit: .hourly, collaborationType: .both, region: .anywhere, techStacks: [.flutter, .java, .kotlin], categoryOfBusiness: .aiDev, jobCategory: "WEB_DEV", oneLineDescription: "5년차 백엔드 개발자입니다. 대용량 트래픽 처리 경험 다수.", rateAmount: 500000, profileImage: "https://s3.ap-northeast-2.amazonaws.com/bucket/linker-profile/456.png"),
      
      MemberProfile(linkerId: "4", nickname: "happy", careerLevel: .junior, workTimeType: .anytime, rateUnit: .hourly, collaborationType: .both, region: .anywhere, techStacks: [.flutter, .java, .kotlin], categoryOfBusiness: .aiDev, jobCategory: "WEB_DEV", oneLineDescription: "5년차 백엔드 개발자입니다. 대용량 트래픽 처리 경험 다수.", rateAmount: 500000, profileImage: "https://s3.ap-northeast-2.amazonaws.com/bucket/linker-profile/456.png")
  ]
  
    displayingUsers = fetcedUsers
  }
  
  func getIndex(user: MemberProfile) -> Int {
    let index = displayingUsers?.firstIndex(where: { currentUser in
      return user.linkerId == currentUser.linkerId
    }) ?? 0
    
    return index
  }
  
  func fetchList() async {
    do {
      let result = try await HomeClient.shared.fetchProfiles(
          type: .member
      )

      if let memberList = result as? [MemberProfile] {
          print(memberList)
      }
    } catch {
      Logger.e("\(error)")
    }
    
  }
}
