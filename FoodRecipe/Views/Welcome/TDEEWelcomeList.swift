//
//  TDEEWelcomeList.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 17/09/2023.
//

import SwiftUI

struct TDEEWelcomeList: View {
    
    @State private var tabIndex: Int = 0
    @AppStorage("initialView") var initialView: Bool = true
    
    var body: some View {
        //MARK: TABVIEW WRAPPER UI
        TabView(selection: $tabIndex) {
            
            OnLoadingPageView(imageName: "lasso.and.sparkles", iconColor: Color.theme.BlueInstance, title: "Welcome to RecipePal", description: "Welcome to RecipePal, your culinary companion! Discover, cook, and share delicious dishes with our user-friendly app. Let's get cooking!", startedButton: false, nextScreen: nextPage)
                .tag(0)
            
            
            OnLoadingPageView(imageName: "carrot.fill", iconColor: Color.theme.Orange, title: "Recipe Categories", description: "Discover a world of flavors with RecipePal's diverse categories, from appetizers to desserts. Whether you're a pro chef or a beginner, find inspiration and guidance in our app. Start your culinary adventure today!", startedButton: false, nextScreen: nextPage)
                .tag(1)
            
            OnLoadingPageView(imageName: "brain.head.profile", iconColor: Color.theme.GrayInstance, title: "TDEE Tracking", description: "But wait, there's more! We're excited to introduce a brand new feature that's all about your health and well-being. With RecipePal's BMI tracking, you can now keep tabs on your health while enjoying amazing recipes", startedButton: true, nextScreen: nextPage)
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
    
    func nextPage() {
        
        if tabIndex < 2 {
            withAnimation{
                tabIndex += 1
            }
        } else {
//            showLoading = false
            initialView = false
        }
    }}

struct TDEEWelcomeList_Previews: PreviewProvider {
    static var previews: some View {
        TDEEWelcomeList()
    }
}
