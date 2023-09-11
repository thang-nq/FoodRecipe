//
//  FoodRecipeApp.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct FoodRecipeApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // init authVM
    @StateObject var authVM = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
        }
    }
}
