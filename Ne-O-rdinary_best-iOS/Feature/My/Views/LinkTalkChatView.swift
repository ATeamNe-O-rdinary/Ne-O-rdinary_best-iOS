import SwiftUI

struct LinkTalkChatView: View {
    let talk: LinkTalkPreview
  @State private var isPresented = false
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "평일은 언제 가능하신가요?", isMe: false)
    ]
    @State private var inputText: String = ""
    @State private var didReceiveReply = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - 상단
            headerView
            
            Divider()
            
            // MARK: - 스크롤 + 자동 스크롤 Reader
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 28) {
                        
                        Text("2025년 11월 23일")
                            .font(.pretendard(13, .medium))
                            .foregroundStyle(Color(hex: "999999"))
                        
                        chatProfileCard
                            .padding(.horizontal, 50)
                        
                        ForEach(messages) { msg in
                            messageRow(msg)
                                .id(msg.id)   // 🔥 스크롤 타겟
                        }
                    }
                    .padding(.top, 20)
                }
                .onChange(of: messages) { _ in
                    scrollToBottom(proxy)
                }
            }
            
            // 외주 시작 버튼
            if didReceiveReply {
                startProjectButton
                  .padding(.top, 10)
            }
            
            // 메시지 입력창
            messageInputBar
        }
        .background(Color.white)
    }
    
    // MARK: - 자동 스크롤 함수
    private func scrollToBottom(_ proxy: ScrollViewProxy) {
        if let lastID = messages.last?.id {
            DispatchQueue.main.async {
                withAnimation(.easeOut(duration: 0.25)) {
                    proxy.scrollTo(lastID, anchor: .bottom)
                }
            }
        }
    }
    
    // MARK: - 헤더
    private var headerView: some View {
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
    }
    
    // MARK: - 메시지 버블
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
                Image("User2")
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
    
    // MARK: - 프로필 카드
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
    
    
    // MARK: - 입력창
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
    
    
    // MARK: - 외주 시작 버튼
    private var startProjectButton: some View {
      
        Button {
          isPresented = true
            print("외주 시작!")
        } label: {
            Text("외주 시작하기")
                .font(.pretendard(16, .semibold))
                .foregroundColor(.white)
                .padding(.vertical, 14)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "FF6A3D"))
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal, 20)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut(duration: 0.25), value: didReceiveReply)
        .fullScreenCover(isPresented: $isPresented) {
          LinkerStartDialog(
            onClose: { isPresented = false },
            onSendLink: {
              print("링크톡 보내기")
              isPresented = false
            }
          )
          .ignoresSafeArea()
        }
        .transaction({ transaction in
          transaction.disablesAnimations = true
        })
    }
    
    
    // MARK: - 메시지 전송 + 자동 답장
    private func sendMessage() {
        guard !inputText.isEmpty else { return }
        
        messages.append(ChatMessage(text: inputText, isMe: true))
        inputText = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            messages.append(ChatMessage(text: "네 외주 진행하겠습니다 😊", isMe: false))
            
            withAnimation {
                didReceiveReply = true
            }
        }
    }
}


// MARK: - 모델
struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isMe: Bool
}


struct LinkerStartDialog: View {
  let onClose: () -> Void
  let onSendLink: () -> Void
  
  var body: some View {
    ZStack {
      // dim
      Color.black.opacity(0.4)
        .ignoresSafeArea()
        .onTapGesture {
          onClose()
        }
      
      // dialog
      VStack(spacing: 20) {
        
        Image("yellow_heart")
        
        VStack(spacing: 6) {
          Text("링커팅의 멤버가 되신것을 환영합니다!")
            .font(.pretendard(16, .medium))
            .foregroundColor(Color(hex: "333333"))
        }
        
        HStack(spacing: 12) {
          Button(action: onClose) {
            Text("닫기")
              .font(.pretendard(15, .medium))
              .frame(maxWidth: .infinity)
              .padding(.vertical, 12)
              .background(Color(hex: "F3F3F4"))
              .foregroundColor(Color(hex: "333333"))
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
          
          Button(action: onSendLink) {
            Text("보러가기")
              .font(.pretendard(15, .medium))
              .frame(maxWidth: .infinity)
              .padding(.vertical, 12)
              .background(Color(hex: "FF6A3D"))
              .foregroundColor(.white)
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
        }
      }
      .padding(26)
      .frame(width: 310)
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .shadow(color: Color.black.opacity(0.15), radius: 16, x: 0, y: 6)
      .transition(.scale.combined(with: .opacity))
      .animation(.spring(response: 0.35, dampingFraction: 0.7), value: true)
    }
    .background(BackgroundBlurView())
  }
}
