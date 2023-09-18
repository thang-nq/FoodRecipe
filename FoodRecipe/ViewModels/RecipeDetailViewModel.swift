//
//  RecipeDetailViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 15/09/2023.
//

import Foundation


@MainActor
class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: Recipe? = nil
    
    func getRecipeDetail(recipeID: String) async {
        self.recipe = nil
        self.recipe = await RecipeManager.shared.getRecipeInformation(recipeID: recipeID)
    }
    
    func getUpdatedRecipeDetail(recipeID: String) async {
        self.recipe = await RecipeManager.shared.getRecipeInformation(recipeID: recipeID)
    }
    
    func getMockRecipeDetail() {
        self.recipe = Recipe.sampleRecipe
    }
    
    func saveOrReomveSavedRecipe(recipeID: String) async {
        await RecipeManager.shared.saveOrRemoveRecipeFromFavorite(recipeID: recipeID)
        await getUpdatedRecipeDetail(recipeID: recipeID)
    }
    
    func updateRecipe(recipeID: String) async throws {
        
    }
    
    func updateCookingStep(recipeID: String, stepID: String, stepData: CookingStepInterface) async throws {
        
    }
    
    
    
    
}
