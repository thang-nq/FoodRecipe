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
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Saved Recipe").font(.custom("ZillaSlab-Bold", size: 30))) {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(destination: RecipeDetailViewDemo(recipe: recipe)) {
                                RecipeCardView(recipe: recipe)
                            }
                        }
                    }.headerProminence(.increased)
                }.listStyle(.insetGrouped)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isDark.toggle() }) {
                        isDark ? Label("Dark", systemImage: "lightbulb.fill") :
                        Label("Dark", systemImage: "lightbulb")
                    }
                }
            }
        }
        .onAppear {
            Task(priority: .medium) {
                do {
                    try await viewModel.getSavedRecipe()
                } catch {
                    // Handle any errors that occur during the async operation
                    print("Error: \(error)")
                }
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
}

struct SavedRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        SavedRecipeListView()
    }
}
