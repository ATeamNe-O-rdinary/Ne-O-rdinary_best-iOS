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
    VStack {
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
      .padding(.top, 30)
      .padding()
      .padding(.vertical)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

#Preview {
  HomeRootView()
}
