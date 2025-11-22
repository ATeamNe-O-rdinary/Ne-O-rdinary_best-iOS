//
//  HomeRootView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import SwiftUI

struct LinkerFinderView: View {
  @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
  
  var body: some View {
    VStack(spacing: 12) {
      if true {
        InterestHeader()
      } else {
        HStack(spacing: 20) {
          Text("아직 로그인하지 않았어요 😢")
            .foregroundStyle(Color(hex: "76797D"))
            .font(.pretendard(14, .medium))
          Spacer()
          Button(action: {}) {
            Text("로그인 하기")
              .font(.pretendard(13, .medium))
              .foregroundStyle(Color(hex: "76797D"))
              .padding(.vertical, 9)
              .padding(.horizontal, 16)
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color.white)
              )
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
          RoundedRectangle(cornerRadius: 8)
            .fill(Color(hex: "F6F6F6"))
        )
      }
      
      ZStack {
        if let users = homeViewModel.displayingUsers {
          if users.isEmpty {
            Text("정보가 없습니다")
              .font(.caption)
              .foregroundStyle(.black)
          } else {
            ForEach(Array(users.prefix(3)).reversed()) { user in
                StackCardView(user: user)
                    .environmentObject(homeViewModel)
            }
          }
        } else {
          ProgressView()
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .padding(.horizontal, 26)
    .padding(.top, 12)
    .padding(.bottom, 40)
  }
}
