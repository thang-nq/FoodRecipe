/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Thang Nguyen
  ID: s3796613
  Created  date: 19/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import Foundation

@MainActor
class UserProfileViewModel: ObservableObject {
    static var shared = UserProfileViewModel()
    @Published var recipeList: [Recipe] = []
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    
    init() {
        Task {
            await getUserCreatedRecipe()
        }
    }
    
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
