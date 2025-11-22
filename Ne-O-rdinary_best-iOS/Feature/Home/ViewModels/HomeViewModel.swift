//
//  HomeViewModel.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {
  @Published var fetcedUsers: [User] = []
  
  @Published var displayingUsers: [User]?
  
  init() {
    fetcedUsers = [
      User(name: "A", place: "Vada Pav", profilePic: "User1"),
      User(name: "A", place: "Vada Pav", profilePic: "User2"),
      User(name: "A", place: "Vada Pav", profilePic: "User1"),
    ]
    
    displayingUsers = fetcedUsers
  }
  
  func getIndex(user: User) -> Int {
    let index = displayingUsers?.firstIndex(where: { currentUser in
      return user.id == currentUser.id
    }) ?? 0
    
    return index
  }
}
