//
//  TDEEWelcomeList.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 17/09/2023.
//

import SwiftUI

struct TDEEWelcomeList: View {
    
    @State private var tabIndex: Int = 0
    @AppStorage("TDDEIntro") var TDDEIntro: Bool = true
    
    var body: some View {
        //MARK: TABVIEW WRAPPER UI
        TabView(selection: $tabIndex) {
            
            OnLoadingPageView(imageName: "lasso.and.sparkles", iconColor: Color.theme.BlueInstance, title: "What is TDEE ?", description:  "Total Daily Energy Expenditure (TDEE) is the total number of calories that your body needs to function on a daily basis. TDEE represents the total amount of energy your body requires to maintain its current weight.", startedButton: false, nextScreen: nextPage)
                .tag(0)
            
            
            OnLoadingPageView(imageName: "figure.run.circle.fill", iconColor: Color.theme.Orange, title: "How to get it? ", description: "You can calculate your TDEE through RecipePal. Calculate your Total Daily Energy Expenditure effortlessly with our integrated feature.", startedButton: false, nextScreen: nextPage)
                .tag(1)
            
            OnLoadingPageView(imageName: "heart.text.square.fill", iconColor: Color.theme.GreenInstance, title: "TDEE Tracking", description: "With RecipePal's TDEE tracking, you can now keep tabs on your health while enjoying amazing recipes", startedButton: true, nextScreen: nextPage)
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
            TDDEIntro = false
        }
    }}

struct TDEEWelcomeList_Previews: PreviewProvider {
    static var previews: some View {
        TDEEWelcomeList()
    }
}
