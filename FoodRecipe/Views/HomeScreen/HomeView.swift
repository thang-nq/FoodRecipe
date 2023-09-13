//
//  HomeView.swift
//  FoodRecipe
//
//  Created by Tien on 13/09/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView{
            RecipeListViewDemo()
                .tabItem(){
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            SavedRecipeListViewDemo()
                .tabItem(){
                    Image(systemName: "heart")
                    Text("Saved Recipe")
                }
            SearchViewDemo()
                .tabItem(){
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            CreateRecipeViewDemo()
                .tabItem(){
                    Image(systemName: "plus")
                    Text("Create Recipe")
                }
            UserProfileViewDemo()
                .tabItem(){
                    Image(systemName: "person")
                    Text("Profile")
                }
        }.tint(Color("Orange"))

    }
}


struct RecipeListViewDemo: View {
    var body: some View {
        Text("RecipeList")
    }
}
struct SavedRecipeListViewDemo: View {
    var body: some View {
        Text("SavedRecipeList")
    }
}
struct SearchViewDemo: View {
    var body: some View {
        Text("Search")
    }
}
struct CreateRecipeViewDemo: View {
    var body: some View {
        Text("CreateRecipe")
    }
}
struct UserProfileViewDemo: View {
    var body: some View {
        Text("UserProfile")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
