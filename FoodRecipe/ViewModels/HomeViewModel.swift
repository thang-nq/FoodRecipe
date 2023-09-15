//
//  HomeViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 15/09/2023.
//

import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    init() {}
    
    func getAllRecipe() async throws {
        self.recipes = try await RecipeManager.shared.getRecipeList()
    }
    
}


/*
 
 var homeViewModel = HomeViewModel()
 
 ForEach(homeViewModel.recipes) { recipe in
  /// render
 }
 
 
 // Call onAppear or button to trigger
 Task {
 try await homeViewModel.getAllRecipe()
 }
 
 
 */
