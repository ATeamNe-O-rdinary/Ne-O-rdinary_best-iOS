//
//  MatchedLingosView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//

import SwiftUI

struct MatchedLingosView: View {
  
    let lingoList: [MatchedLingo] = [
        MatchedLingo(name: "모바일 앱 개발자 (Flutter)", company: "(주) 링커팀", logo: "company_img1"),
        MatchedLingo(name: "프론트엔드 개발자", company: "(주) 비즈빌", logo: "company_img2"),
        MatchedLingo(name: "백엔드 개발자", company: "(주) 비즈빌", logo: "company_img3"),
        MatchedLingo(name: "백엔드 개발자", company: "(주) 비즈빌", logo: "company_img2"),
        MatchedLingo(name: "백엔드 개발자", company: "(주) 비즈빌", logo: "company_img1")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(lingoList, id: \.id) { lingo in
                    lingoRow(lingo)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .background(Color.white)
    }
    
    
    // MARK: - 링오 한 줄 UI
    private func lingoRow(_ lingo: MatchedLingo) -> some View {
        HStack(spacing: 16) {
            
            Image(lingo.logo)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 5) {
                Text(lingo.name)
                    .font(.pretendard(16, .semibold))
                    .foregroundColor(.black)
                
                Text(lingo.company)
                    .font(.pretendard(14, .medium))
                    .foregroundColor(Color(hex: "666666"))
            }
            
            Spacer()
            
            // 오른쪽 메시지 아이콘
            Image(systemName: "paperplane.fill")
                .font(.system(size: 18))
                .foregroundColor(Color(hex: "999999"))
                .frame(width: 34, height: 34)
                .background(Color(hex: "F3F3F4"))
                .clipShape(Circle())
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.07), radius: 6, x: 0, y: 4)
        )
    }
}

struct MatchedLingo: Identifiable {
    let id = UUID()
    let name: String
    let company: String
    let logo: String
}

#Preview {
    MatchedLingosView()
}
