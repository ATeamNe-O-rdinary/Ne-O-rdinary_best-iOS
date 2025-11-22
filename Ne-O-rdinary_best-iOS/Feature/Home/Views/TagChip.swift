//
//  TagChip.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import SwiftUI

struct TagChip: View {
  let text: String
  
  var body: some View {
    Text("#\(text)")
      .font(.pretendard(14, .medium))
      .foregroundColor(Color(hex: "666666"))          // 글자 색
      .padding(.vertical, 8)
      .padding(.horizontal, 12)
      .background(
        Capsule()
          .fill(Color.white)                  // 안쪽 흰색
          .overlay(
            Capsule()
              .stroke(Color(hex: "F3EFEF"), lineWidth: 1) // 옅은 테두리
          )
      )
  }
}
