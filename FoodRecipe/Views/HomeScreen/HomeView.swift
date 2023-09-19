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
            RecipeListView()
                .tabItem(){
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            SavedRecipeListView()
                .tabItem(){
                    Image(systemName: "heart")
                    Text("Saved Recipe")
                }
            SearchView()
                .tabItem(){
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
//            CreateRecipeView()
            CreateRecipeView()
                .tabItem(){
                    Image(systemName: "brain")
                    Text("TDEE")
//                    Text("Create Recipe")
                }
            UserProfileViewDemo()
                .tabItem(){
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .edgesIgnoringSafeArea(.bottom)
        .accentColor(Color.theme.Orange)

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
