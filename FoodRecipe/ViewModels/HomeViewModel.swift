//
//  HomeViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 15/09/2023.
//

import SwiftUI
import PhotosUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    init() {}
    
    func getAllRecipe() async throws {
        self.recipes = try await RecipeManager.shared.getRecipeList()
    }
    
    func getRecipeByMealType(mealType: String) async throws {
        self.recipes = try await RecipeManager.shared.getRecipeByFilters(filters: ["mealType": mealType])
    }
    
    func getRecipeByFilters(filters: [String: Any]) async throws {
        self.recipes = try await RecipeManager.shared.getRecipeByFilters(filters: filters)
    }
    
    func addRecipe(recipe: Recipe, image: PhotosPickerItem?) async throws {
        try await RecipeManager.shared.createNewRecipe(recipe: recipe, backgroundImage: image)
        try await getAllRecipe()
    }
    
    func deleteRecipe(recipeID: String) async throws {
        try await RecipeManager.shared.deleteRecipe(recipeID: recipeID)
        try await getAllRecipe()
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
