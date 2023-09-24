/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Thang Nguyen
  ID: s3796613
  Created  date: 10/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
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
