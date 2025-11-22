//
//  LinkTalkChatView.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/23/25.
//

import SwiftUI

struct LinkTalkChatView: View {
    let talk: LinkTalkPreview
    
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "평일은 언제 가능하신가요?", isMe: false)
    ]
    @State private var inputText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - 상단 프로필
            HStack(spacing: 12) {
                Image(talk.logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(talk.company)
                        .font(.pretendard(15, .semibold))
                    
                    Text(talk.title)
                        .font(.pretendard(13, .medium))
                        .foregroundStyle(Color(hex: "777777"))
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            
            Divider()
            
            // MARK: - 채팅 영역
            ScrollView {
                VStack(spacing: 28) {
                    
                    Text("2025년 11월 23일")
                        .font(.pretendard(13, .medium))
                        .foregroundStyle(Color(hex: "999999"))
                    
                    chatProfileCard
                        .padding(.horizontal, 50)
                    
                    // MARK: - 메시지 반복
                    ForEach(messages) { msg in
                        messageRow(msg)
                    }
                }
                .padding(.top, 20)
            }
            
            // MARK: - 입력창
            messageInputBar
        }
        .background(Color.white)
    }
    
    // MARK: - 메시지 버블 UI
    private func messageRow(_ msg: ChatMessage) -> some View {
        HStack(alignment: .bottom, spacing: 8) {
            
            if msg.isMe {
                Spacer()
                
                Text(msg.text)
                    .padding(12)
                    .background(Color(hex: "FF6A3D"))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
            } else {
                Image(talk.logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(msg.text)
                    .padding(12)
                    .background(Color(hex: "F1F1F1"))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - 프로필 카드 (맨 위 카드)
    private var chatProfileCard: some View {
        VStack(spacing: 12) {
            Image("User1")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            Text("링커 프로필 보기")
                .font(.pretendard(14, .semibold))
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "FF6A3D"))
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(hex: "F7F7F8"))
        )
        .padding(.horizontal, 16)
    }
    
    // MARK: - 메시지 입력창
    private var messageInputBar: some View {
        HStack(spacing: 12) {
            TextField("대화를 입력하세요", text: $inputText)
                .padding(12)
                .background(Color(hex: "F3F3F4"))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Button {
                sendMessage()
            } label: {
                Image(systemName: "paperplane.fill")
                    .font(.system(size: 22))
                    .foregroundColor(Color(hex: "FF6A3D"))
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
    
    // MARK: - 메시지 전송
    private func sendMessage() {
        guard !inputText.isEmpty else { return }
        messages.append(ChatMessage(text: inputText, isMe: true))
        inputText = ""
    }
}


// MARK: - 채팅 메시지 모델
struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isMe: Bool
}
