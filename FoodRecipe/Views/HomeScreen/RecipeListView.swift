//
//  RecipeListView.swift
//  FoodRecipe
//
//  Created by Tien on 15/09/2023.
//

import SwiftUI


struct RecipeListView: View {
    @StateObject private var viewModel = HomeViewModel()
    @AppStorage("isDarkMode") var isDark = false
    func saveAction(recipeId: String) {
        Task {
            await viewModel.saveOrRemoveRecipe(recipeID: recipeId)
        }
    }
    func fetchRecipes() {
        Task {
            do {
                try await viewModel.getAllRecipe()
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
                    Text("Today's Recipes")
                        .font(Font.custom.NavigationTitle)
                    VStack {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipeId: recipe.id!, onDissappear: fetchRecipes).navigationBarHidden(true)) {
                                RecipeCardView(recipe: recipe, saveAction: saveAction)
                            }
                        }
                    }.padding(10)
                }.padding(10)
                    .frame(width: 390)
                    .overlay(
                        HStack {
                            NavigationLink(destination: CreateRecipeView()) {
                                Image(systemName: "flame")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.theme.Orange)
                                    .clipShape(Circle())
                            }
                        }.padding(15),
                        
                        alignment: .bottomTrailing
                    )
            }
            .onAppear {
                fetchRecipes()
            }
            .environment(\.colorScheme, isDark ? .dark : .light)
        }
    }
}


struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
