//
//  HomeViewModel.swift
//  FoodRecipe
//
//  Created by Thang Nguyen on 11/09/2023.
//


import FirebaseFirestore
import FirebaseFirestoreSwift


@MainActor
class RecipeViewModel: ObservableObject {
    
    @Published private(set) var recommendRecipes: [Recipe] = []
    @Published var favoriteRecipes: [Recipe] = []
    @Published var filteredRecipes: [Recipe] = []
    @Published var myRecipeList: [Recipe] = []
    private var db = Firestore.firestore()
    static let shared = RecipeViewModel()
    
    private init() {
    }
    
    func getRecipeList() async {
        let recipes = try? await RecipeManager.shared.getRecipeList()
        self.recommendRecipes = recipes ?? []
    }
    
    
    func getFavoriteRecipeList() {
        
    }
    
    func removeFavoriteRecipe(recipeID: String) {
        
    }
    
    func getUserCreatedRecipeList(userID: String) async throws {
        let recipes = try await RecipeManager.shared.getUserCreatedRecipeList(userID: userID)
        print(recipes)
        self.myRecipeList = recipes
    }
    
    func createRecipe(currentUser: User?, recipeData: Recipe) async throws {
        do {
            if currentUser == nil {
                throw RecipeManagerError.userNotLoggedIn
            }
            
            
            
            
        } catch {
            print("DEBUG - \(error.localizedDescription)")
        }
    }

    
}
