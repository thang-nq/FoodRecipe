//
//  HomeView.swift
//  FoodRecipe
//
//  Created by Tien on 11/09/2023.
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
                    Image(systemName: "bookmark.fill")
                    Text("Saved Recipe")
                }
            SearchView()
                .tabItem(){
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }.tint(Color("Orange"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
