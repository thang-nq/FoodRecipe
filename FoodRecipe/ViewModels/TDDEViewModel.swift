//
//  TDDEViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 20/09/2023.
//

import Foundation

@MainActor
class TDDEViewModel : ObservableObject {
    static let shared = TDDEViewModel()
    @Published var tddeRecipes: [Recipe] = []
    @Published var recommendCal: Int = UserManager.shared.currentUser!.recommendCal
    @Published var recommendProtein: Int = 0
    @Published var recommendCarb: Int = 0
    @Published var recommendFat: Int = 0
    @Published var consumedCal: Int = 0
    
    
    private init() {
        Task {
            await self.getTDDERecipe()
        }
    }

    
    func getTDDERecipe() async {
        if UserManager.shared.currentUser != nil {
            self.consumedCal = 0
            self.tddeRecipes = await RecipeManager.shared.getUserTDDERecipes()
            print("TDDE recipes: \(self.tddeRecipes.count)")
            self.recommendCal = try! await UserManager.shared.getCurrentUserData()!.recommendCal
            let protein = Double(self.recommendCal) * 0.35
            self.recommendProtein = Int(protein/4)
            
            let fat = Double(self.recommendCal) * 0.2
            self.recommendFat = Int(fat/9)
            
            let carb = Double(self.recommendCal) * 0.45
            self.recommendCarb = Int(carb/4)
            for recipe in tddeRecipes {
                consumedCal += recipe.calories
            }
        }
        
    }
    
    func addRecipeToTDDE(recipeID: String) async {
        await RecipeManager.shared.addRecipeToTDDE(recipeID: recipeID)
        await getTDDERecipe()
    }
    
    func removeRecipeFromTDDE(recipeID: String) async {
        await RecipeManager.shared.removeRecipeFromTDDE(recipeID: recipeID)
        await getTDDERecipe()
    }
    
    
    func calculateTDDE(age: Int, height: Int, weight: Int, gender: String, activityLevel: Double) async {
        if let currentUser = UserManager.shared.currentUser {
            var recCalories: Int = 0
            if gender == "MALE" {
                let result = 10 * Float(weight) + 6.25 * Float(height) - 5 * Float(age) + 5
                recCalories = Int(round(result * Float(activityLevel)))
            } else if gender == "FEMALE" {
                let result = 10 * Float(weight) + 6.25 * Float(height) - 5 * Float(age) - 161
                recCalories = Int(round(result * Float(activityLevel)))
            }
            self.recommendCal = recCalories
            try? await UserManager.shared.updateUser(userID: currentUser.id, updateValues: ["recommendCal": recCalories, "enableTDDE": true])
            await getTDDERecipe()
            
        }
    }
    
    
}
