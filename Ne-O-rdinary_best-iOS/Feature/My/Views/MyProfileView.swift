//
//  MyProfileView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//

import SwiftUI

struct MyProfileView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 24) {
      Text("링크팅")
        .font(.pretendard(16, .semibold))
        .foregroundColor(.black)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      // 여기에 실제 프로필 내용 추가하면 됨
      VStack(spacing: 16) {
        Text("프로필 정보를 여기에 보여줄 수 있어요.")
          .font(.pretendard(16, .regular))
          .foregroundColor(.gray)
      }
      
      Spacer()
    }
    .background(Color.white)
    .padding(.top, 4)
    .padding(.horizontal, 26)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

#Preview {
  MyProfileView()
}
