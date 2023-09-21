//
//  SavedRecipeListView.swift
//  FoodRecipe
//
//  Created by Tien on 15/09/2023.
//

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
            NavigationView {
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
//                    .toolbar {
//                        ToolbarItem(placement: .navigationBarTrailing) {
//                            Button(action: { isDark.toggle() }) {
//                                isDark ? Label("Dark", systemImage: "lightbulb.fill") :
//                                Label("Dark", systemImage: "lightbulb")
//                            }
//                        }
//                    }
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
