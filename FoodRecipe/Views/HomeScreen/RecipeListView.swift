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
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Today's Recipes").font(.custom("ZillaSlab-Bold", size: 30))) {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipeId: recipe.id!).navigationBarHidden(true)) {
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
                    try await viewModel.getAllRecipe()
                } catch {
                    // Handle any errors that occur during the async operation
                    print("Error: \(error)")
                }
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
}

struct RecipeCardView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading){
            Image(recipe.backgroundURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(5)
            HStack{
                Text(recipe.name)
                        .font(.custom("ZillaSlab-SemiBold", size: 26))
                        .padding(.top, 10)
                        .frame(width: 220, alignment: .leading)
            }.frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                ForEach(recipe.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.custom("ZillaSlab-Regular", size: 20))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color("Orange"))
                        .cornerRadius(8)
                }
                Spacer()
            }
            .padding(.bottom, 10)
                  
            Text(recipe.intro)
                .font(.custom("ZillaSlab-Regular", size: 20))
            
            }
            .overlay(
                        Button(action: {
                        // Handle save action
                        }) {
                            Image(systemName: "heart")
                        }
                        .foregroundColor(Color("Orange"))
                        .buttonStyle(PlainButtonStyle())
                        .padding(.trailing, 16)
                        .font(.system(size: 25))
                        .offset(x:140, y:50)
            )
        .padding(.bottom, 10)
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
