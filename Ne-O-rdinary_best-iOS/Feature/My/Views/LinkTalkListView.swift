//
//  LinkTalkListView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//


import SwiftUI
import Kingfisher

struct LinkTalkListView: View {
    let talks: [LinkTalkPreview] = [
        LinkTalkPreview(
            company: "(주) 링크팀",
            title: "모바일 앱 개발자 (Flutter)",
            lastMessage: "시급 말고 건 별로는 가능한가요?",
            logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/42f9490f-86bb-48a8-a689-2defc80c84cc.png"
        ),
        LinkTalkPreview(
            company: "(주) 버즈빌",
            title: "프론트엔드 개발자",
            lastMessage: "평일 시간은 언제 가능하신가요?",
            logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/9ae7176a-269c-4d0d-8cfd-5678742854ab.png"
        ),
        LinkTalkPreview(
            company: "(주) CMC",
            title: "백엔드 개발자",
            lastMessage: "개발 기간이 더 길어질 수도 있어요",
            logo: "https://nerdinery-bucket.s3.ap-northeast-2.amazonaws.com/default/c448066f-a703-4638-b903-d6aa1d1adbbd.png"
        )
    ]
    
    var onSelectTalk: (LinkTalkPreview) -> Void
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(talks) { talk in
                    Button {
                        onSelectTalk(talk)
                    } label: {
                        HStack(spacing: 12) {
                          KFImage(URL(string: talk.logo))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(talk.company) · \(talk.title)")
                                    .font(.pretendard(15, .semibold))
                                    .foregroundColor(.black)
                                
                                Text(talk.lastMessage)
                                    .font(.pretendard(14, .medium))
                                    .foregroundColor(Color(hex: "777777"))
                            }
                            
                            Spacer()
                        }
                    }
                }
            }
            .padding(.top, 32)
            .padding(.horizontal, 20)
        }
    }
}

struct LinkTalkPreview: Identifiable {
    let id = UUID()
    let company: String
    let title: String
    let lastMessage: String
    let logo: String
}
