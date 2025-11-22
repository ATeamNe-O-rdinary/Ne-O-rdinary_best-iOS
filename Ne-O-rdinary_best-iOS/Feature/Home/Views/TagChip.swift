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
      .font(.system(size: 14, weight: .medium))
      .foregroundColor(Color(.darkGray))          // 글자 색
      .padding(.vertical, 6)
      .padding(.horizontal, 12)
      .background(
        Capsule()
          .fill(Color.white)                  // 안쪽 흰색
          .overlay(
            Capsule()
              .stroke(Color(.systemGray4), lineWidth: 1) // 옅은 테두리
          )
      )
  }
}
