//
//  FoodRecipeApp.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 10/09/2023.
//

import SwiftUI
import Firebase


@main
struct FoodRecipeApp: App {
    init() {
        FirebaseApp.configure()
    }
    // init authVM
    @StateObject private var authVM = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authVM)
        }
    }
}
