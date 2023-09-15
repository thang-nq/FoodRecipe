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
