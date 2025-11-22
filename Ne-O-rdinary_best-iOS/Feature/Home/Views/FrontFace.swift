//
//  FrontFace.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//

import SwiftUI

struct FrontFace: View {
  let user: User
  let size: CGSize
  let topOffset: CGFloat
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 24)
        .fill(.white)
        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
        .shadow(radius: 4)
      VStack {
        ZStack(alignment: .bottom) {
          Image(user.profilePic)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 228)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
              // 아래쪽 절반만 검정 그라데이션
              LinearGradient(
                gradient: Gradient(colors: [
                  Color.black.opacity(0.0),
                  Color.black.opacity(0.5)
                ]),
                startPoint: .top,
                endPoint: .bottom
              )
              .clipShape(RoundedRectangle(cornerRadius: 12))
            )
          
          HStack {
            VStack(alignment: .leading, spacing: 4) {
              Text("프론트엔드 개발자 주니어")
                .foregroundStyle(Color(hex: "f2f2f2"))
                .font(.pretendard(12, .regular))
              Text("이름")
                .foregroundStyle(Color(hex: "ffffff"))
                .font(.pretendard(18, .semibold))
            }
            Spacer()
            Button {
              Logger.d("링킹!")
            } label: {
              Image("link_icon")
                .frame(width: 48, height: 48)
            }
          }
          .frame(maxWidth: .infinity)
          .padding(16)
          .background(
            RoundedRectangle(cornerRadius: 12)
              .fill(Color.white).opacity(0.2)
              .overlay(
                RoundedRectangle(cornerRadius: 12)
                  .stroke(Color(.systemGray4), lineWidth: 1)
              )
          )
          .padding(16)
        }
        .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
        
        VStack(alignment: .leading, spacing: 20) {
          VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
              Text("한줄소개")
                .foregroundStyle(Color(hex: "777980"))
                .font(.pretendard(14, .regular))
                .frame(maxWidth: .infinity, alignment: .leading)
              Text("스타트업 근무 중인 프론트엔드 개발자입니다")
                .foregroundStyle(Color(hex: "414245"))
                .font(.pretendard(14, .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 4) {
              HStack(spacing: 12) {
                Text("업무 방식")
                  .foregroundStyle(Color(hex: "777980"))
                  .font(.pretendard(14, .medium))
                Text("풀타임 가능")
                  .foregroundStyle(Color(hex: "222222"))
                  .font(.pretendard(14, .medium))
              }
              
              HStack(spacing: 12) {
                Text("희망 단가")
                  .foregroundStyle(Color(hex: "777980"))
                  .font(.pretendard(14, .medium))
                HStack(spacing: 2) {
                  Text("80,000원")
                    .foregroundStyle(Color(hex: "222222"))
                    .font(.pretendard(14, .medium))
                  Text("건당")
                    .foregroundStyle(Color(hex: "777980"))
                    .font(.pretendard(13, .regular))
                }
              }
              
              HStack(spacing: 12) {
                Text("선호 지역")
                  .foregroundStyle(Color(hex: "777980"))
                  .font(.pretendard(14, .medium))
                Text("서울")
                  .foregroundStyle(Color(hex: "222222"))
                  .font(.pretendard(14, .medium))
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              ForEach(["웹 퍼블리싱", "반응형", "React", "아아아", "오오오오"], id: \.self) { tag in
                TagChip(text: tag)
              }
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(26)
        
        Spacer()
      }
    }
    .padding(4)
    .frame(width: size.width - topOffset, height: size.height)
  }
}
