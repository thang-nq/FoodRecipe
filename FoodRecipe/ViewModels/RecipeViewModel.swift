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
    private var db = Firestore.firestore()
    static let shared = RecipeViewModel()
    
    private init() {
    }
    
    func getRecipeList() async {
//        db.collection("recipes").getDocuments { snapshot, error in
//            if error == nil {
//                if let snapshot = snapshot {
//                    self.recommendRecipes = snapshot.documents.map { d in
//                        return Recipe(id: d.documentID,
//                                      name: d["name"] as? String ?? "",
//                                      creatorUID: d["creatorUID"] as? String ?? "",
//                                      backgroundURL: d["backgroundURL"] as? String ?? "")
//                    }
//
//                    print(self.recommendRecipes)
//                } else {
//
//                }
//
//            }
//            else {
//                print("DEBUG - \(error!.localizedDescription)")
//            }
//        }
        
        let recipes = try? await RecipeManager.shared.getRecipeList()
        self.recommendRecipes = recipes ?? []
    }
    
    
    func getFavoriteRecipeList() {
        
    }
    
    func removeFavoriteRecipe(recipeID: String) {
        
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
