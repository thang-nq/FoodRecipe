//
//  CreateRecipeView.swift
//  FoodRecipe
//
//  Created by Tien on 13/09/2023.
//

import SwiftUI
import SlidingTabView

struct CreateRecipeView: View {
    @State private var selectedTabIndex = 0
    var body: some View {
//        VStack{
//            HStack{
//                Text("Recipename:")
//                        .font(.custom("ZillaSlab-SemiBold", size: 26))
//                        .padding(.leading, 20)
//                Spacer()
//            }
//
//            TextField(("Enter recipe name"), text: $recipeName)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .font(.custom("ZillaSlab-Regular", size: 18))
//                .padding(.leading, 20)
//                .padding(.trailing, 20)
//            HStack{
//                Text("Ingredients:")
//                        .font(.custom("ZillaSlab-SemiBold", size: 26))
//                        .padding(.leading, 20)
//                Spacer()
//            }
//        }
        VStack {
            
            SlidingTabView(selection: self.$selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom("ZillaSlab-Regular", size: 22),  activeAccentColor: Color.theme.Orange, selectionBarColor: Color.theme.Orange)
            
            if selectedTabIndex == 0 {
                CreateIntroView()
            }
            
            if selectedTabIndex == 1 {
                CreateIngredientsView()
            }
            
            if selectedTabIndex == 2 {
                CreateStepsView()
            }
            
        }.background(Color.theme.White)
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
