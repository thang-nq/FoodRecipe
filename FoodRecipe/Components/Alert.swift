/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/



import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: String
    var message: String
    var buttonTitle: String
}
