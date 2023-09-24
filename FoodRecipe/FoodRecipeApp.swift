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
import Firebase


@main
struct FoodRecipeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
//    @StateObject private var authVM = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
