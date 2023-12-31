/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Team Android
  Created  date: 13/09/2023
  Last modified: 24/09/2023
*/

import SwiftUI

import SwiftUI

struct SavedRecipeListView: View {
    @StateObject private var viewModel = HomeViewModel()
    @AppStorage("isDarkMode") var isDark = false
    func saveAction(recipeId: String) -> Void {
        Task {
            await viewModel.saveOrRemoveRecipe(recipeID: recipeId)
        }
    }
    func fetchSavedRecipes() -> Void {
        Task(priority: .medium) {
            do {
                try await viewModel.getSavedRecipe()
            } catch {
                // Handle any errors that occur during the async operation
                print("Error: \(error)")
            }
        }
    }
    var body: some View {
        VStack {
            NavigationStack {
                ScrollView {
                    Text("Saved Recipes")
                        .font(Font.custom.NavigationTitle)
                    VStack {
                        ForEach(viewModel.savedRecipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipeId: recipe.id!, onDissappear: fetchSavedRecipes).navigationBarHidden(true)) {
                                RecipeCardView(recipe: recipe, saveAction: saveAction)
                            }
                        }
                    }.padding(10)
                }.padding(10)
                    .frame(width: 390)
            }
            .onAppear {
                fetchSavedRecipes()
            }
            .environment(\.colorScheme, isDark ? .dark : .light)
        }
    }
}

struct SavedRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        SavedRecipeListView()
    }
}
