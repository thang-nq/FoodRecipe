/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/

import Foundation
import PhotosUI
import SwiftUI

// View model for the detail screen
@MainActor
class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: Recipe? = nil
    @Published var showError: Bool = false
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
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
        isLoading.toggle()
        await RecipeManager.shared.saveOrRemoveRecipeFromFavorite(recipeID: recipeID)
        await getUpdatedRecipeDetail(recipeID: recipeID)
        isLoading.toggle()
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
    
    func addCookingStep(recipeID: String, context: String, backgroundImage: PhotosPickerItem?, stepNumber: Int) async {
        do {
            try await RecipeManager.shared.addCookingStep(recipeID: recipeID, context: context, backgroundImage: backgroundImage, stepNumber: stepNumber)
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
    
    func addRecipeToTDDE(recipeID: String) async {
        isLoading.toggle()
        do {
            try await RecipeManager.shared.addRecipeToTDDE(recipeID: recipeID)
        }
        isLoading.toggle()
        
    }
}
