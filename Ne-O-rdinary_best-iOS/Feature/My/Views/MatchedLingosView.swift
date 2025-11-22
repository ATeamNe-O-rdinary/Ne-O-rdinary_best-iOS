//
//  MatchedLingosView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//

import SwiftUI
import Kingfisher

struct MatchedLingosView: View {
  let matchedLingoList: [MatchedLingo] = [
      MatchedLingo(
          name: "모바일 앱 개발자 (iOS)",
          company: "CMC",
          logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/42f9490f-86bb-48a8-a689-2defc80c84cc.png"
      ),
      MatchedLingo(name: "웹사이트 리뉴얼 프론트엔드",
                   company: "블루웨이브소프트",
                   logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/9ae7176a-269c-4d0d-8cfd-5678742854ab.png"
      ),
  ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
              ForEach(matchedLingoList, id: \.id) { lingo in
                    lingoRow(lingo)
                  .padding(.vertical, 8)
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
            
          KFImage(URL(string: lingo.logo))
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
