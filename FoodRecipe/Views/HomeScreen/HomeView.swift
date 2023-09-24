/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Tien Tran
  ID: s3919657
  Created  date: 13/09/2023
  Last modified: 24/09/2023
  Acknowledgement: Acknowledge the resources that you use here.
*/

import SwiftUI

struct HomeView: View {
    
    @AppStorage("isDarkMode") var isDark = false
    
    init(){
        UITabBar.appearance().backgroundColor = UIColor(named: "TabBarColor")
        UITabBar.appearance().unselectedItemTintColor = UIColor(named: "UnTintColor")
    }
    
    var body: some View {
        
        NavigationStack {
            TabView{
                RecipeListView()
                    .tabItem(){
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                SavedRecipeListView()
                    .tabItem(){
                        Image(systemName: "heart")
                        Text("Saved")
                    }
                SearchView()
                    .tabItem(){
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                TDEEPersonalView()
                    .tabItem(){
                        Image(systemName: "heart.text.square.fill")
                        Text("TDEE")
                    }
                UserProfileView()
                    .tabItem(){
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            .tint(Color.theme.Orange)
            .scrollContentBackground(.hidden)
            .edgesIgnoringSafeArea(.bottom)
            .accentColor(Color.theme.Orange)
            .toolbar {
            // MARK: Tool Bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isDark.toggle() }) {
                        isDark ? Label("Dark", systemImage: "sun.max.fill") :
                        Label("Dark", systemImage: "moon.fill")
                    }
                    .foregroundColor(Color.theme.OrangeInstance)
                }
            }
            
            
        }
        .environment(\.colorScheme, isDark ? .dark : .light)

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
