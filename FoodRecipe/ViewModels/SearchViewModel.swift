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
    @Published var searchString: String = ""
    
    func searchRecipeByText() async {
        self.recipes = await RecipeManager.shared.searchRecipeByText(text: searchString)
    }
    
    func searchRecipeByTags(tags: [String]) async {
        self.recipes = await RecipeManager.shared.filterRecipeByTags(tags: tags)
    }
    
    func searchAllRecipe() async {
        self.recipes = await RecipeManager.shared.searchAllRecipes()
    }
}
