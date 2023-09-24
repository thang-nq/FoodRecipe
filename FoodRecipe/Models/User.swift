/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    var avatarUrl: String = "default.jpeg"
    var savedRecipe: [String] = []
    var enableTDDE: Bool = false
    var recommendCal: Int = 0
//    var gender: String = "Not set"
    var tddeRecipes: [String] = []
//    var bio: String = "This is user bio"
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Test User", email: "test@gmail.com")
}
