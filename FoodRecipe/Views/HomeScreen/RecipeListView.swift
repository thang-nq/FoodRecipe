//
//  RecipeListView.swift
//  FoodRecipe
//
//  Created by Tien on 11/09/2023.
//

import SwiftUI


struct RecipeListView: View {
    @AppStorage("isDarkMode") var isDark = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Today's Recipes").font(.custom("ZillaSlab-Bold", size: 30))) {
                        ForEach(recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
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
        }.environment(\.colorScheme, isDark ? .dark : .light)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
