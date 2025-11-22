//
//  InterestHeader.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//


import SwiftUI

struct InterestHeader: View {
  var body: some View {
    HStack(spacing: 0) {
      // 왼쪽 카드
      HStack(spacing: 4) {
        
        HStack(spacing: 16) {
          Text("관심 분야")
            .font(.system(size: 14))
            .foregroundColor(Color(.darkGray))
          
          Divider()
            .frame(height: 16)
            .overlay(Color(.systemGray4))
          
          Text("앱 제작")
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(Color(red: 1.0, green: 0.35, blue: 0.2)) // 오렌지
        }
        
        Spacer()
        
        Button(action: {}) {
          Text("수정하기")
            .font(.system(size: 13))
            .foregroundColor(.black)
            .padding(.vertical, 9)
            .padding(.horizontal, 12)
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
                )
            )
        }
      }
      .frame(maxWidth: .infinity)
      .padding(.vertical, 12)
      .padding(.horizontal, 16)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(Color(.systemGray6))
      )
      
      Spacer()
      
      // 오른쪽 동그란 버튼
      Button(action: {}) {
        Image(systemName: "arrow.counterclockwise")
          .font(.system(size: 18, weight: .semibold))
          .foregroundColor(Color(.darkGray))
          .frame(width: 36, height: 36)
          .background(
            Circle()
              .fill(Color.white)
              .shadow(color: Color.black.opacity(0.05),
                      radius: 4, x: 0, y: 2)
          )
      }
    }
  }
}

#Preview {
  InterestHeader()
    .padding()
}
