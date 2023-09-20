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
    @Published var tddeCount: Int = 0
    
    
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
    
    func calculateTDDE(age: Int, height: Int, weight: Int, gender: String, activityLevel: Float) async {
        if let currentUser = UserManager.shared.currentUser {
            var recCalories: Int = 0
            if gender == "MALE" {
                let result = 10 * Float(weight) + 6.25 * Float(height) - 5 * Float(age) + 5
                recCalories = Int(round(result))
            } else if gender == "FEMALE" {
                let result = 10 * Float(weight) + 6.25 * Float(height) - 5 * Float(age) - 161
                recCalories = Int(round(result))
            }
            try? await UserManager.shared.updateUser(userID: currentUser.id, updateValues: ["recommendCal": recCalories, "enableTDDE": true])
        }
    }
    
    
}
