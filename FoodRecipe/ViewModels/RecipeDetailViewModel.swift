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
    
    func getRecipeDetail(recipeID: String) async throws {
        self.recipe = try await RecipeManager.shared.getRecipeInformation(recipeID: recipeID)
    }
    
    
}
