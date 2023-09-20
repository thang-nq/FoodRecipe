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
    @Published var savedRecipes: [Recipe] = []
    @Published var showError: Bool = false
    @Published var errorMessage: String?
    
    init() {
        Task {
            await getAllRecipe()
        }
    }
    
    func getAllRecipe() async {
        self.recipes = await RecipeManager.shared.getRecipeList()
    }
    
    func getRecipeByMealType(mealType: String) async {
        self.recipes = await RecipeManager.shared.getRecipeByFilters(filters: ["mealType": mealType])
    }
    
    
    func addRecipe(recipe: Recipe, image: PhotosPickerItem?, cookingSteps: [CookingStepInterface]?) async {
        do {
            try await RecipeManager.shared.createNewRecipe(recipe: recipe, backgroundImage: image, cookingSteps: cookingSteps)
            await getAllRecipe()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }

    }
    
    func deleteRecipe(recipeID: String) async throws {
        do {
            try await RecipeManager.shared.deleteRecipe(recipeID: recipeID)
            await getAllRecipe()
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func searchRecipeByTags(tags: [String]) async {
        self.recipes = await RecipeManager.shared.filterRecipeByTags(tags: tags)
    }
    
    func searchRecipeByText(text: String) async {
        self.recipes = await RecipeManager.shared.searchRecipeByText(text: text)
    }
    
    
    func saveOrRemoveRecipe(recipeID: String) async {
        if let userData = UserManager.shared.currentUser {
            await RecipeManager.shared.saveOrRemoveRecipeFromFavorite(recipeID: recipeID)
        }
        await getSavedRecipe()
        await getAllRecipe()
        
    }
    
    func getSavedRecipe() async {
        var recipes: [Recipe] = []
        if UserManager.shared.currentUser != nil {
            let userData = await UserManager.shared.getUserData(userID: UserManager.shared.currentUser!.id)
            recipes = await RecipeManager.shared.getUserSavedRecipes(userID: userData!.id)
        }
        self.savedRecipes = recipes
    }
    
    func addRecipeToTDDE(recipeID: String) async {
        await RecipeManager.shared.addRecipeToTDDE(recipeID: recipeID)
    }
    
    // To be removed
    func getRecipeByFilters(filters: [String: Any]) async {
        self.recipes = await RecipeManager.shared.getRecipeByFilters(filters: filters)
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
