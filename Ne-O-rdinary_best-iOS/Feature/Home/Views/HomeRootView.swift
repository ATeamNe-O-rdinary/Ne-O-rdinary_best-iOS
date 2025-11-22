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
            Text("없음")
              .foregroundStyle(.black)
          } else {
            ForEach(users) { user in
              StackCardView(user: user)
                .environmentObject(homeViewModel)
            }
          }
        }
      }
      .padding(.top, 30)
      .padding()
      .padding(.vertical)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      
      HStack(spacing: 15) {
        Button {
          
        } label: {
          Image(systemName: "arrow.uturn.backward")
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(.white)
            .shadow(radius: 5)
            .padding(13)
            .background(.gray)
            .clipShape(Circle())
        }
        
        Button {
          
        } label: {
          Image(systemName: "xmark")
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(.white)
            .shadow(radius: 5)
            .padding(13)
            .background(.gray)
            .clipShape(Circle())
        }
        
        Button {
          
        } label: {
          Image(systemName: "star.fill")
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(.white)
            .shadow(radius: 5)
            .padding(13)
            .background(.gray)
            .clipShape(Circle())
        }
        
        Button {
          
        } label: {
          Image(systemName: "suit.heart.fill")
            .font(.system(size: 15, weight: .bold))
            .foregroundStyle(.white)
            .shadow(radius: 5)
            .padding(13)
            .background(.gray)
            .clipShape(Circle())
        }
      }
    }
  }
}

#Preview {
  HomeRootView()
}
