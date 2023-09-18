//
//  RecipeDetailViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 15/09/2023.
//

import Foundation
import PhotosUI
import SwiftUI


@MainActor
class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: Recipe? = nil
    @Published var showError: Bool = false
    @Published var errorMessage: String?
    
    func getRecipeDetail(recipeID: String) async {
        self.recipe = nil
        self.recipe = await RecipeManager.shared.getRecipeInformation(recipeID: recipeID)
    }
    
    func getMockRecipeDetail() {
        self.recipe = Recipe.sampleRecipe
    }
    
    func saveOrReomveSavedRecipe(recipeID: String) async {
        await RecipeManager.shared.saveOrRemoveRecipeFromFavorite(recipeID: recipeID)
        await getRecipeDetail(recipeID: recipeID)
    }
    
    func updateRecipe(recipeID: String, updateData: updateRecipeInterface) async {
        do {
            try await RecipeManager.shared.updateRecipe(recipeID: recipeID, updateData: updateData)
            await getRecipeDetail(recipeID: recipeID)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
        
    }
    
    func updateCookingStep(recipeID: String, stepID: String, context: String?, backgroundImage: PhotosPickerItem?) async {
        do {
            try await RecipeManager.shared.updateCookingStep(recipeID: recipeID, stepID: stepID, context: context, backgroundImage: backgroundImage)
            await getRecipeDetail(recipeID: recipeID)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func deleteCookingStep(recipeID: String, stepID: String) async {
        do {
            try await RecipeManager.shared.deleteCookingStep(recipeID: recipeID, stepID: stepID)
            await getRecipeDetail(recipeID: recipeID)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }
    }
    
    func deleteRecipe(recipeID: String) async throws {
        do {
            try await RecipeManager.shared.deleteRecipe(recipeID: recipeID)
        } catch {
            errorMessage = error.localizedDescription
            showError = true
        }

    }
    
    
    
    
}
