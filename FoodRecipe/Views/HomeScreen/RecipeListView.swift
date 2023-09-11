//
//  RecipeListView.swift
//  FoodRecipe
//
//  Created by Tien on 11/09/2023.
//

import SwiftUI


struct RecipeListView: View {
    @AppStorage("isDarkMode") var isDark = false
    @State private var searchText = ""

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Today's Recipes")) {
                        ForEach(filteredRecipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                                RecipeCardView(recipe: recipe)
                            }
                        }
                    }.headerProminence(.increased)
                }.listStyle(.insetGrouped)
            }
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isDark.toggle() }) {
                        isDark ? Label("Dark", systemImage: "lightbulb.fill") :
                        Label("Dark", systemImage: "lightbulb")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Handle profile button action
                    }) {
                        Image("user")
                    }
                }
            }
        }.environment(\.colorScheme, isDark ? .dark : .light)
    }
}






struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
