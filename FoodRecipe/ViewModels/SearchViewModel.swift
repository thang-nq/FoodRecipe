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


// View model for the search screen
@MainActor
class SearchViewModel: ObservableObject {
    @Published var recipes : [Recipe] = []
    @Published var searchString: String = ""
    @Published var currentSelectedTags: [String] = []
    @Published var currentSelectedMealTypes: [String] = []
    
    func searchRecipeByText() async {
        let results = await RecipeManager.shared.searchRecipeByText(text: searchString)
        if(currentSelectedTags.count > 0 || currentSelectedMealTypes.count > 0) {
            let final = results.filter { recipe in
                var found = false
                if(currentSelectedMealTypes.contains(recipe.mealType.lowercased())) {
                    found = true
                }
                for tag in recipe.tags {
                    print(tag)
                    if(self.currentSelectedTags.contains(tag.lowercased())) {
                        found = true
                        break
                    }
                }
                return found
            }
            self.recipes = final
        }else {
            self.recipes = results
        }
    }
    
    func searchRecipeByTags(tags: [String]) async {
        let queryArr = tags.map { $0.capitalized}
        print(queryArr)
        self.recipes = await RecipeManager.shared.filterRecipeByTags(tags: queryArr)
    }
    
    func searchAllRecipe() async {
        self.recipes = await RecipeManager.shared.searchAllRecipes()
    }
}
