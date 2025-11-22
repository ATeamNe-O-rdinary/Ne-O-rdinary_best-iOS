//
//  HomeRootView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import SwiftUI

struct HomeRootView: View {
  @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
  
  var body: some View {
    VStack(spacing: 12) {
      InterestHeader()
      
      ZStack {
        if let users = homeViewModel.displayingUsers {
          if users.isEmpty {
            Text("정보가 없습니다")
              .font(.caption)
              .foregroundStyle(.black)
          } else {
            ForEach(users.reversed()) { user in
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

#Preview {
  HomeRootView()
}
