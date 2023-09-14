//
//  OnLoadingList.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 14/09/2023.
//

import SwiftUI

struct OnLoadingList: View {
    
//    @Binding var showLoading: Bool
    @State private var tabIndex: Int = 0
    @AppStorage("initialView") var initialView: Bool = true

    
    var body: some View {
        //MARK: TABVIEW WRAPPER UI
        TabView(selection: $tabIndex) {
            
            OnLoadingPageView(imageName: "brain.head.profile", iconColor: Color.theme.DarkBlueInstance, title: "RecipePal Hello", description: "Welcome to RecipePal, your culinary companion! Discover, cook, and share delicious dishes with our user-friendly app. Let's get cooking!", startedButton: false, nextScreen: nextPage)
                .tag(0)
            
            
            OnLoadingPageView(imageName: "carrot.fill", iconColor: Color.theme.Orange, title: "RecipePal Hello", description: "Welcome to RecipePal, your culinary companion! Discover, cook, and share delicious dishes with our user-friendly app. Let's get cooking!", startedButton: false, nextScreen: nextPage)
                .tag(1)
            
            OnLoadingPageView(imageName: "fish.fill", iconColor: Color.theme.BlueInstance, title: "RecipePal Hello", description: "Welcome to RecipePal, your culinary companion! Discover, cook, and share delicious dishes with our user-friendly app. Let's get cooking!", startedButton: true, nextScreen: nextPage)
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
    }
    
}


struct OnLoadingList_Previews: PreviewProvider {
    static var previews: some View {
//        OnLoadingList(showLoading: .constant(true))
        OnLoadingList()

    }
}
