//
//  SaveRecipeViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 19/09/2023.
//

import Foundation

@MainActor
class UserProfileViewModel: ObservableObject {
    @Published var recipeList: [Recipe] = []
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    
    func getUserCreatedRecipe() async {
        do {
            if let currentUser = UserManager.shared.currentUser {
                self.recipeList = try await RecipeManager.shared.getUserCreatedRecipeList(userID: currentUser.id)
            } else {
                throw RecipeManagerError.userNotLoggedIn
            }
        } catch {
            self.errorMessage = error.localizedDescription
            self.showError = true
        }
        
    }
    
    func deleteRecipe(recipeID: String) async {
        do {
            try await RecipeManager.shared.deleteRecipe(recipeID: recipeID)
        } catch {
            self.errorMessage = error.localizedDescription
            self.showError = true
        }
    }
    
    func updateUserData(dataToUpdate: [String: Any]) async {
        do {
            if let currentUser = UserManager.shared.currentUser {
                try await UserManager.shared.updateUser(userID: currentUser.id, updateValues: dataToUpdate)
            } else {
                throw UserManagerError.userIDNotFound
            }
        } catch {
            self.errorMessage = error.localizedDescription
            self.showError = true
        }
    }
    
    

    
}
