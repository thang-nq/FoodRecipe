//
//  SearchViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 15/09/2023.
//

import Foundation

@MainActor
class SearchViewModel: ObservableObject {
    @Published var recipes : [Recipe] = []
    
    func searchRecipeByText(text: String) async {
        self.recipes = await RecipeManager.shared.searchRecipeByText(text: text)
    }
    
    func searchRecipeByTags(tags: [String]) async {
        self.recipes = await RecipeManager.shared.filterRecipeByTags(tags: tags)
    }
    
    
    func saveOrRemoveRecipe(recipeID: String) async {
        if let userData = UserManager.shared.currentUser {
            await RecipeManager.shared.saveOrRemoveRecipeFromFavorite(recipeID: recipeID)
        }
//        await getAllRecipe()
    }
    
//    func save
}
