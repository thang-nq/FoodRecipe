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
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Today's Recipes").font(.custom("ZillaSlab-Bold", size: 30))) {
                        ForEach(viewModel.recipes) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipeId: recipe.id!, onDissappear: fetchRecipes).navigationBarHidden(true)) {
                                RecipeCardView(recipe: recipe, saveAction: saveAction)
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
            fetchRecipes()
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
}

struct RecipeCardView: View {
    var recipe: Recipe
    var saveAction: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading){
            FirebaseImage(imagePathName: recipe.backgroundURL)
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .cornerRadius(5)
            HStack{
                Text(recipe.name)
                    .font(Font.custom.Heading)
                    .padding(.top, 10)
                    .frame(width: 220, alignment: .leading)
            }.frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                ForEach(recipe.tags, id: \.self) { tag in
                    Text(tag)
                        .font(Font.custom.Content)
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
                //                homeVM
                saveAction(recipe.id!)
            }) {
                Image(systemName: recipe.isSaved ? "heart.fill" : "heart")
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
