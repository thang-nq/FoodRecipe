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
    @AppStorage("isDarkMode") var isDark = false
    @StateObject var createRecipeVM = CreateRecipeViewModel()
    var body: some View {
        
        //MARK: MAIN LAYOUT
        ZStack{
            
            VStack {
                
                topBar
                    .accessibilityLabel("Top bar")
                
                slidingTab
                    .accessibilityLabel("Sliding tab")
                
            }
            .overlay(
            // MARK: SHOW THE SUCCESS POP UP
                ZStack {
                    if createRecipeVM.showPopUp {
                        Color.theme.DarkWhite.opacity(0.5)
                            .edgesIgnoringSafeArea(.all)
                        PopUp(iconName: createRecipeVM.popUpIcon , title: createRecipeVM.popUptitle, content: createRecipeVM.popUpContent, iconColor: createRecipeVM.popUpIconColor ,didClose: {createRecipeVM.showPopUp = false})
                    }
                }
                    .opacity(createRecipeVM.showPopUp ? 1 : 0)
            )
            .background(Color.theme.White)
            
            // MARK: CHECK LOADING
            if (createRecipeVM.isLoading == true){
                ZStack {
                    Color(.black)
                        .ignoresSafeArea()
                        .opacity(0.5)
                        .background(Color.clear)
                    
                    Progress(loadingSize: 3)
                }
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
        .navigationBarBackButtonHidden(true)
    }
}

struct CreateRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRecipeView()
    }
}

private extension CreateRecipeView{
    
    //MARK: TOP BAR UI
    var topBar: some View{
        HStack {
            Spacer()
            ExitButton()
            Spacer()
            // Title of the view
            Text("Create recipe")
                .font(Font.custom.NavigationTitle)
                .padding(.leading, 30)
            
            Spacer()
            
            // Button create new recipe
            Button(action: {
                // Create recipe
                createRecipeVM.createRecipe()
            }) {
                Text("Create")
                    .font(.system(size: 20))
                
            }
            .padding(.trailing, 20)
            .disabled(createRecipeVM.isValidCreate())
          
        }
    }
    
    //MARK: SLIDING TAB UI
    var slidingTab: some View{
        VStack{
            SlidingTabView(selection: $createRecipeVM.selectedTabIndex, tabs: ["Intro","Ingredients", "Steps"], font: .custom("ZillaSlab-Regular", size: 22),    activeAccentColor: Color.theme.Orange, inactiveAccentColor : Color.theme.Gray, selectionBarColor: Color.theme.Orange)
            // Check the selected tab index
            if createRecipeVM.selectedTabIndex == 0 {
                CreateIntroView(backgroundPhoto: $createRecipeVM.backgroundPhoto ,recipeName: $createRecipeVM.recipeName, cookingTime: $createRecipeVM.cookingTime, servingSize: $createRecipeVM.servingSize, description: $createRecipeVM.description, calories: $createRecipeVM.calories, carb: $createRecipeVM.carb, protein: $createRecipeVM.protein, fat: $createRecipeVM.fat, sugars: $createRecipeVM.sugars, salt: $createRecipeVM.salt, saturates: $createRecipeVM.saturates, fibre: $createRecipeVM.fibre, currentSelectedTags: $createRecipeVM.currentSelectedTags, currentSelectedMealTypes: $createRecipeVM.currentSelectedMealTypes)
            }
            if createRecipeVM.selectedTabIndex == 1 {
                CreateIngredientsView(Ingredients: $createRecipeVM.Ingredients)
            }
            if createRecipeVM.selectedTabIndex == 2 {
                CreateStepsView(Steps: $createRecipeVM.Steps, listStepsPhoto: $createRecipeVM.listStepsPhoto, backgroundPhoto: $createRecipeVM.backgroundPhoto)
            }
        }
    }
    
}
