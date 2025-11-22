//
//  User.swift
//  Ne-O-rdinary_best-iOS
//
//  Created by 임경빈 on 11/22/25.
//

import SwiftUI

struct User: Identifiable {
  var id = UUID().uuidString
  var name: String
  var place: String
  var profilePic: String
}
