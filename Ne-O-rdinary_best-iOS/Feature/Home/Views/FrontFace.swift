//
//  FrontFace.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//

import SwiftUI
import Kingfisher

struct FrontFace: View {
  let user: ProjectProfile
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
          KFImage(URL(string: user.profileImage))
              .placeholder {
                  Color.gray.opacity(0.2)   // 로딩 중 placeholder
              }
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
              Text(user.companyName)
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
            VStack(alignment: .leading, spacing: 8) {
              Text("D-21")
                .foregroundStyle(Color(hex: "FF704D"))
                .font(.pretendard(14, .medium))
                .padding(.vertical, 2)
                .padding(.horizontal, 8)
                .background(Color(hex: "FFE2DB"))
                .clipShape(RoundedRectangle(cornerRadius: 4))
              
              Text(user.projectIntro)
                .foregroundStyle(Color.black)
                .font(.pretendard(16, .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 4) {
              HStack(spacing: 12) {
                Text("예산 범위")
                  .foregroundStyle(Color(hex: "777980"))
                  .font(.pretendard(14, .medium))
                Text("\(user.rateAmount)만원 ~ \(user.rateAmount * 2)만원")
                  .foregroundStyle(Color(hex: "222222"))
                  .font(.pretendard(14, .medium))
              }
              
              HStack(spacing: 12) {
                Text("예상 기간")
                  .foregroundStyle(Color(hex: "777980"))
                  .font(.pretendard(14, .medium))
                HStack(spacing: 2) {
                  Text("\(user.expectedDuration)")
                    .foregroundStyle(Color(hex: "222222"))
                    .font(.pretendard(14, .medium))
                }
              }
              
              HStack(spacing: 12) {
                Text("협업 형태")
                  .foregroundStyle(Color(hex: "777980"))
                  .font(.pretendard(14, .medium))
                Text(user.collaborationType.description)
                  .foregroundStyle(Color(hex: "222222"))
                  .font(.pretendard(14, .medium))
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
              ForEach(user.techStacks, id: \.self) { tag in
                TagChip(text: tag.description)
              }
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 10, leading: 26, bottom: 26, trailing: 26))
        
        Spacer()
      }
    }
    .padding(4)
    .frame(width: size.width - topOffset, height: size.height)
  }
}
