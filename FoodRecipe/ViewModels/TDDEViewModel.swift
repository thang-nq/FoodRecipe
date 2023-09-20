//
//  TDDEViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 20/09/2023.
//

import Foundation

@MainActor
class TDDEViewModel : ObservableObject {
    @Published var tddeRecipes: [Recipe] = []
    
    init() {
        Task {
            await self.getTDDERecipe()
        }
    }

    
    func getTDDERecipe() async {
        self.tddeRecipes = await RecipeManager.shared.getUserTDDERecipes()
    }
    
    func removeRecipeFromTDDE(recipeID: String) async {
        await RecipeManager.shared.removeRecipeFromTDDE(recipeID: recipeID)
        await getTDDERecipe()
    }
    
    func calculateTDDE(age: Int, height: Int, gender: String, activityLevel: Float) async {
//        print("AGE: \(ageInt); HEIGHT: \(heightInt); GENDER: \(gender); ACTIVITY LEVEL: \(activityLevel)")
    }
    
    
}
