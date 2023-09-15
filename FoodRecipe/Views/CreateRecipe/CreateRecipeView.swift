//
//  CreateRecipeView.swift
//  FoodRecipe
//
//  Created by Tien on 16/09/2023.
//

import SwiftUI
import SlidingTabView
import PhotosUI

struct CreateRecipeView: View {
    @State private var backgroundPhoto: PhotosPickerItem? = nil
    @State private var recipeName = ""
    @State private var minutes = ""
    @State private var description = ""
    @State private var calories: Int = 0
    @State private var carb: Int = 0
    @State private var protein: Int = 0
    @State private var fat: Int = 0
    @State private var sugars: Int = 0
    @State private var salt: Int = 0
    @State private var saturates: Int = 0
    @State private var fibre: Int = 0
    
    @State private var Ingredients: [String] = []
    
   @State private var Steps: [String] = []
   @State private var listStepsPhoto: [PhotosPickerItem] = []
    
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
            HStack {
                Spacer()
                Text("Create new recipe")
                    .font(.custom("ZillaSlab-Bold", size: 25))
                    .padding(.leading, 70)
                
                Spacer()
                
                Button(action: {
                    // Create button action
                }) {
                    Text("Create")
                        .font(.system(size: 20))
            
                }.padding(.trailing, 20)
            }
            SlidingTabView(selection: self.$selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom("ZillaSlab-Regular", size: 22),  activeAccentColor: Color.theme.Orange, selectionBarColor: Color.theme.Orange)
            
            if selectedTabIndex == 0 {
                CreateIntroView(backgroundPhoto: $backgroundPhoto ,recipeName: $recipeName, minutes: $minutes, description: $description, calories: $calories, carb: $carb, protein: $protein, fat: $fat, sugars: $sugars, salt: $salt, saturates: $saturates, fibre: $fibre)
            }
            
            if selectedTabIndex == 1 {
                CreateIngredientsView(Ingredients: $Ingredients)
            }
            
            if selectedTabIndex == 2 {
                CreateStepsView(Steps: $Steps, listStepsPhoto: $listStepsPhoto)
            }
            
        }.background(Color.theme.White)
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}
